class Pgloupe < Formula
  desc "A close look at your Postgres logs and query stats."
  homepage "https://github.com/vtrbraga/pgloupe"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.2/pgloupe-aarch64-apple-darwin.tar.gz"
      sha256 "9b72b404080c9577f8ccd556e26663dc7b95bdec42895bd8cd3655813d74b6d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.2/pgloupe-x86_64-apple-darwin.tar.gz"
      sha256 "f0cb22e94bd4706feb2be4053fed3295216fa9c6caf12c16f2c06cbf22b15209"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.2/pgloupe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8e94f2434b179fa8b1d59a98d08cdded2263539e1eb14c373d53c258bbf35620"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.2/pgloupe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0ea5e3cc9cca538047474195a0eb762aa5591a477a0bf73119805369e382b959"
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
