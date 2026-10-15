class Pgloupe < Formula
  desc "A close look at your Postgres logs and query stats."
  homepage "https://github.com/vtrbraga/pgloupe"
  version "0.1.0-alpha.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.2/pgloupe-aarch64-apple-darwin.tar.gz"
      sha256 "50f3c4ae13892c51d95a30174b7be0c49dc1f7f3ea80a128d0d1c7a8cf1c6003"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.2/pgloupe-x86_64-apple-darwin.tar.gz"
      sha256 "eca5471bc019db2e943ef754d114ac1a21226eb78b521da127b5a877cbffa703"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.2/pgloupe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b2400b6ea7a056b274aadd2e68b0d7c91020df222237c5112217c05f5bb973f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.2/pgloupe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc72a326467520aa430e35586bd59c01a817f8675178448172cf68f032e340d9"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pgloupe"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pgloupe"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pgloupe"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pgloupe"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
