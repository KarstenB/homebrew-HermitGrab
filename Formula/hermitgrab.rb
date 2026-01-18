class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "21a36481004e31e8150d8e18c947a001468cb586808be1c1e58900e2892dc3fd"
  else
    url "https://github.com/karstenb/hermitgrab/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "4dc89adc563a894380d75b6f6a2d20dae792781f201a42113c9e94f431ad72d5"
  end

  version "v0.1.9"
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
