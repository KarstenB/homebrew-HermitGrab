class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "03098fb7808513047da274db3f5c84617ee778c9444ee064fe2a701d0fc12c75"
  else
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "118aaf8bd8cf7ead68301e95d8a6048fe2be38ab6e5b10a0474a7232a35b7415"
  end

  version "v0.2.0"
  license "GPL-3.0-only"
  depends_on "xz"

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
