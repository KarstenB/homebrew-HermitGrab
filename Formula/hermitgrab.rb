class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://hermitgrab.app/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "4befa8bfbdc222ad68470cd974d99a70e28e023d777dca2e777b138086702f7c"
  else
    url "https://hermitgrab.app/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "69eb39d806ed6bc2744c6537e26d7afeed90918b4682d7ba5f519f48e5cca9c8"
  end

  version "latest"
  license "GPL-3.0-only"

  def install
    bin.install "hermitgrab"

    # Attempt ad-hoc codesign
    system "codesign", "--force", "--deep", "--sign", "-", bin/"hermitgrab"

    # Optionally remove quarantine attribute
    if MacOS.version >= :catalina
      # Silently ignore if quarantine attribute doesn't exist
      system "xattr", "-d", "com.apple.quarantine", bin/"hermitgrab" rescue nil
    end
  end

  test do
    system "#{bin}/hermitgrab", "--version"
  end
end
