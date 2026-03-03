class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "54332250ed70f13e930b6ffdc92811d7a3d39c49c794102b5b40858a29e43c91"
  else
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "bdf10371a841d446630e4f62f311de3d1a35d7ceaaf7b86621b2810bd565058d"
  end

  version "v0.2.1"
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
