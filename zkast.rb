class Zkast < Formula
  desc "A command-line tool for managing your notes with a beautiful TUI interface"
  homepage "https://github.com/SirSerje/zkast"
  url "https://github.com/SirSerje/zkast/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7a75c6e0dd693969712369f99996620c8018097d18d98138d1a5a67db6cb9912" # Run: shasum -a 256 <tarball> after creating release
  license "MIT"

  depends_on "python3"

  def install
    system "python3", "-m", "pip", "install", "--prefix=#{prefix}", "."
  end

  test do
    system "#{bin}/zkast", "--version"
  end
end
