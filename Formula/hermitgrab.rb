class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://hermitgrab.app/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "1e62eabc3309e9a1b2be61475baa2bc43b9274dbbc444b3f5ba7261248b14f76"
  else
    url "https://hermitgrab.app/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "228b10fed0b3268a2c5618ba7f190f90b806ab4095cebc7ae15323413c6ee7d2"
  end

  version "v0.1.7"
  license "GPL-3.0-only"

  def install
    bin.install "hermitgrab"

    # Attempt ad-hoc codesign
    system "codesign", "--force", "--deep", "--sign", "-", bin/"hermitgrab"

    system <<~EOS
      if xattr -p com.apple.quarantine #{bin/"hermitgrab"} >/dev/null 2>&1; then
        xattr -d com.apple.quarantine #{bin/"hermitgrab"}
      fi
    EOS
  end

  test do
    system "#{bin}/hermitgrab", "--version"
  end
end
