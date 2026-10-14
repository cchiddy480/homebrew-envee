class ForgeBootstrap < Formula
  include Language::Python::Virtualenv

  desc "Create a verified development environment from an empty directory"
  homepage "https://github.com/cchiddy480/forge-bootstrap"
  url "https://github.com/cchiddy480/forge-bootstrap/releases/download/v0.1.0/forge_bootstrap-0.1.0.tar.gz"
  sha256 "b5dd03de4c735a2a71e417e08ca31432eb809fd6c2b4dbee926985fc51b10d8f"
  license "MIT"

  depends_on "python@3.14"

  resource "click" do
    url "https://files.pythonhosted.org/packages/c7/0e/7fa0ef50764b67090eca4114772a2abf8b6148198475e54c660b97caeee6/click-8.5.0.tar.gz"
    sha256 "ba0d2089de75ea0310e2dde03160e6ca10009947fb95a182f9b54021bb272e34"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/e9/67/cae617f1351490c25a4b8ac3b8b63a4dda609295d8222bad12242dfdc629/rich-14.3.4.tar.gz"
    sha256 "817e02727f2b25b40ef56f5aa2217f400c8489f79ca8f46ea2b70dd5e14558a9"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  def install
    virtualenv_install_with_resources
    generate_completions_from_executable(bin/"forge", shell_parameter_format: :click)
  end

  def caveats
    <<~EOS
      Start a project: forge init ./my-project
      Check your tools: forge doctor

      Forge includes its own Python environment. Node 22, Docker and Azure
      Functions Core Tools are needed only for the project types you select.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
    system bin/"forge", "init", "sample", "--preset", "python", "--yes", "--no-install", "--no-git"
    assert_path_exists testpath/"sample/forge.json"
    assert_path_exists testpath/"sample/scripts/project.py"
    manifest = JSON.parse((testpath/"sample/forge.json").read)
    assert_equal "python", manifest["preset"]
    assert_equal "local", manifest["environment"]
    assert_match "must be empty", shell_output("#{bin}/forge init sample --yes 2>&1", 1)
  end
end
