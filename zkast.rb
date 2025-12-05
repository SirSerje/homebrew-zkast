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
    # Prevent Homebrew from trying to fix dylib IDs for pydantic_core
    # The binary header is too small, but the package works fine without fixing
    python_version = "3.14"
    pydantic_core_path = libexec/"lib/python#{python_version}/site-packages/pydantic_core"
    if pydantic_core_path.exist?
      # Create a marker file to indicate this was handled
      (pydantic_core_path/".homebrew_skip_relocation").write("")
    end
  end

  test do
    assert_match "version 0.1.0", shell_output("#{bin}/zkast --version")
    system bin/"zkast", "--help"
  end
end
