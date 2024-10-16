class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/rs1090"
  version "0.3.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.8/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "fdbfe5212cd0c805c5963b829d64904a1f46a2c824de382bfbf538334d285b37"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.8/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "259be5ad266ec3f01a54e3837d6a4f36684d84bb1754ad9b8348b269d374c2ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.8/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8860529a84e33f905be1e0b5aa57ecd0309f53459de8535527cf2ad318cafcc1"
    end
  end
  license "MIT"
  
  depends_on "soapyrtlsdr"
  depends_on "soapysdr"
  depends_on "soapysdr"
  depends_on "soapysdr"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "decode1090"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "decode1090"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "decode1090"
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
