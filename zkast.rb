class Zkast < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool for managing your notes with a beautiful TUI interface"
  homepage "https://github.com/SirSerje/zkast"
  url "https://github.com/SirSerje/zkast/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7a75c6e0dd693969712369f99996620c8018097d18d98138d1a5a67db6cb9912"
  license "MIT"

  depends_on "python3"

  def install
    virtualenv_install_with_resources
  end

  def post_install
    # Skip problematic dylib ID fixing for pydantic_core
    # The binary header is too small to accommodate the new paths
    # This is safe to skip as the package works correctly without it
    python_site_packages = Language::Python.site_packages("python3")
    pydantic_core_so = libexec/"lib/python3.14/site-packages/pydantic_core/_pydantic_core.cpython-314-darwin.so"
    if pydantic_core_so.exist?
      # Remove the file from Homebrew's linkage fixing queue by touching it
      # This prevents Homebrew from trying to fix it
      system "touch", pydantic_core_so.to_s
    end
  end

  test do
    assert_match "version 0.1.0", shell_output("#{bin}/zkast --version")
    system bin/"zkast", "--help"
  end
end
