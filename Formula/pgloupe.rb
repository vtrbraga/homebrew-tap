class Pgloupe < Formula
  desc "A close look at your Postgres logs and query stats."
  homepage "https://github.com/vtrbraga/pgloupe"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.4/pgloupe-aarch64-apple-darwin.tar.gz"
      sha256 "31b025db8fb89cd36e7351fb9f88fad1aa46bd6c6939bf50cd6b4932d8643eaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.4/pgloupe-x86_64-apple-darwin.tar.gz"
      sha256 "c38a22f25484b62c7d7a932763b29f7d5ae33b9e08b1a2aadc4cb63d659c3dc1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.4/pgloupe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a98c127b7bbf4e1b9ff912b4c1c86af36f3e61e2bc3c64950e518bfacb021441"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.4/pgloupe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a29a85f46807db3eca9a597aec21709de4ae275ba868ef5735c0165d0e71e284"
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
