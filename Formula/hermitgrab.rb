class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "9ce3db57a12862542f942a382ffe7d6a960e83c8ea990e020dc79e0afc092bbe"
  else
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "348d417e14b5187280424183be307f7b23b8148074836cc1f2362c3560ddca58"
  end

  version "v0.1.8"
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
