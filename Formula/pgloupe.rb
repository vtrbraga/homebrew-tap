class Pgloupe < Formula
  desc "A close look at your Postgres logs and query stats."
  homepage "https://github.com/vtrbraga/pgloupe"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0/pgloupe-aarch64-apple-darwin.tar.gz"
      sha256 "7c1222089bf950c586dfac3153d435a0a6f26a0d99a2ac27c6e551004d8d318f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0/pgloupe-x86_64-apple-darwin.tar.gz"
      sha256 "581e5cfb9055de46db55dc837a788708418ed06b16bd9beca13fcd5ca56019fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0/pgloupe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f40359060d303419fc0d8319c1f799d80a2693a32bad88dc528efe04f10d6f1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0/pgloupe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ee19535324aee3882693240fe0946ccfbe9dd4b0784a3a701f208aeaebda1c8d"
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
