class Zkast < Formula
  desc "Command-line tool for managing your notes with a beautiful TUI interface"
  homepage "https://github.com/SirSerje/zkast"
  url "https://github.com/SirSerje/zkast/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7a75c6e0dd693969712369f99996620c8018097d18d98138d1a5a67db6cb9912"
  license "MIT"

  depends_on "python3"

  def install
    # Use pip install with --no-deps first, then install dependencies
    # This prevents Homebrew from trying to fix dylib IDs on the main package
    system "python3", "-m", "pip", "install", "--no-deps", "--prefix=#{prefix}", "--no-warn-script-location", "."
    system "python3", "-m", "pip", "install", "--prefix=#{prefix}", "--no-warn-script-location", "-r", buildpath/"requirements.txt"
  end

  test do
    assert_match "version 0.1.0", shell_output("#{bin}/zkast --version")
    system bin/"zkast", "--help"
  end
end
