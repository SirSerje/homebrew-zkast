class Zkast < Formula
  desc "Command-line tool for managing your notes with a beautiful TUI interface"
  homepage "https://github.com/SirSerje/zkast"
  url "https://github.com/SirSerje/zkast/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7a75c6e0dd693969712369f99996620c8018097d18d98138d1a5a67db6cb9912"
  license "MIT"

  depends_on "python3"

  def install
    system "python3", "-m", "pip", "install", "--prefix=#{prefix}", "--no-warn-script-location", "."
  end

  def post_install
    # pydantic_core's binary has a header that's too small for Homebrew's dylib ID fixing
    # This is safe to ignore - the package works correctly without the fix
    python_site_packages = prefix/"lib/python3.14/site-packages"
    pydantic_core_so = python_site_packages/"pydantic_core/_pydantic_core.cpython-314-darwin.so"
    return unless pydantic_core_so.exist?

    # Try to fix the dylib ID manually with a workaround
    # If it fails, that's okay - the package still works
    begin
      system "install_name_tool", "-id", "@rpath/_pydantic_core.cpython-314-darwin.so", pydantic_core_so.to_s
    rescue StandardError
      # Ignore errors - package works fine without this fix
    end
  end

  test do
    assert_match "version 0.1.0", shell_output("#{bin}/zkast --version")
    system bin/"zkast", "--help"
  end
end
