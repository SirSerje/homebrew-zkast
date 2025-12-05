class Zkast < Formula
  desc "Command-line tool for managing your notes with a beautiful TUI interface"
  homepage "https://github.com/SirSerje/zkast"
  url "https://github.com/SirSerje/zkast/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7a75c6e0dd693969712369f99996620c8018097d18d98138d1a5a67db6cb9912"
  license "MIT"

  depends_on "python3"

  def install
    # Skip problematic dylib ID fixing for Python extensions
    ENV["HOMEBREW_SKIP_OR_LATER_CHECK"] = "1"
    system "python3", "-m", "pip", "install", "--prefix=#{prefix}", "--no-warn-script-location", "--no-deps", "."
    system "python3", "-m", "pip", "install", "--prefix=#{prefix}", "--no-warn-script-location", "-r", buildpath/"requirements.txt"
  end

  test do
    assert_match "version 0.1.0", shell_output("#{bin}/zkast --version")
    system bin/"zkast", "--help"
  end
end
