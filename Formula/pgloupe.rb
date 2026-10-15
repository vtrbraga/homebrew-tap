class Pgloupe < Formula
  desc "A close look at your Postgres logs and query stats."
  homepage "https://github.com/vtrbraga/pgloupe"
  version "0.1.0-alpha.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.1/pgloupe-aarch64-apple-darwin.tar.gz"
      sha256 "39a71c1c632b957b24716d0b8cd0ea2e8e17575dffb142a89905a85f739a8c16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.1/pgloupe-x86_64-apple-darwin.tar.gz"
      sha256 "db2801db003795462013ccfcc95699d083a5743db1aaeb5edf334fa95365b6f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.1/pgloupe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d357b7f9edecc370399e0fd99a69843fe11bbe86cbf90e907c5ed795512f0391"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vtrbraga/pgloupe/releases/download/v0.1.0-alpha.1/pgloupe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "88f4fd0f6ee7cafca1e800e070be15bc15e67415cd6e185d875ec9c3b4eeeaa7"
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
