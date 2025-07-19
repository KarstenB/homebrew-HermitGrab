class Hermitgrab < Formula
  desc "A tag-based configuration manager"
  homepage "https://github.com/karstenb/hermitgrab"
  url "https://github.com/karstenb/hermitgrab/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "5e8ca96d91227b87adb6ee3b9d31c036de8c8294260b30c66780e6b4efae1736"
  license "GPL3"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/hermitgrab", "--version"
  end
end
