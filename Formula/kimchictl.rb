# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.24"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.24/kimchictl-darwin-arm64"
      sha256 "4c1a930d651c17529f22330d6f904af8fbc2894ed3ca1e3d7e9b5028728f6d1a"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.24/kimchictl-darwin-x64"
      sha256 "5358368ffc9421717c5697ab73359263250f750e6033667b8061529a668bd3c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.24/kimchictl-linux-arm64"
      sha256 "30e0e2b9daf883f85015550f5c7ba5f74c84b972dc53af9682f0afb11147d791"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.24/kimchictl-linux-x64"
      sha256 "16a4f32622f77c5110627aeb918eed971871d091d35695d6f32698158d1cdf7d"
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
