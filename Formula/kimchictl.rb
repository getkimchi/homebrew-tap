# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.28"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.28/kimchictl-darwin-arm64"
      sha256 "aa5f9632c6b40f3fa09c4a464b4a32e86684ca069fef3a5f3fce4db7598a408b"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.28/kimchictl-darwin-x64"
      sha256 "625b3fcfa54d2683d8424bf88935988012bee5ef2e7b78043c708b091c8bf321"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.28/kimchictl-linux-arm64"
      sha256 "051ffec03a1c71ab2085e146916c06796b17697bb0ba01d3bf1e2f82d7a1b123"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.28/kimchictl-linux-x64"
      sha256 "90d41fda526a6b84bd429aa082f855f4187215e6eaf25bda12fec6d8d93970f3"
    end
  end

  def install
    bin.install Dir["kimchictl-*"].first => "kimchictl"
  end

  def post_install
    # Native SSH integration is configured at install time. Opt out with
    # KIMCHICTL_NO_SSH_SETUP=1; undo with `kimchictl ssh setup --uninstall`.
    unless ENV["KIMCHICTL_NO_SSH_SETUP"]
      system bin/"kimchictl", "ssh", "setup"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kimchictl version")
  end
end
