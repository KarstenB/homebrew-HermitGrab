class Hermitgrab < Formula
  desc "Minimal binary fetcher for hermit"
  homepage "https://hermitgrab.app"
  
  if Hardware::CPU.arm?
    url "https://hermitgrab.app/releases/latest/download/hermitgrab-macos-aarch64.zip"
    sha256 "483fb0b7c4530368f208cf58e8e90b013c03bc37df380e74f1a2fe1dc200cb88"
  else
    url "https://hermitgrab.app/releases/latest/download/hermitgrab-macos-x86_64.zip"
    sha256 "1632c05370bc8b76f24453a4957e41828b65705011d5b4e4f0793701f797afb9"
  end

  version "v0.1.6"
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
