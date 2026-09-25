# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.4/kimchictl-darwin-arm64"
      sha256 "efc618f935608cd57ef8f3a8c4d3dae2505f9bc8e233eea279bbaacaf1996d9d"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.4/kimchictl-darwin-x64"
      sha256 "5fa5ca2b4a71ec89ff6a713e73ec3f8486d07de7f974d73be0cede8071c77669"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.4/kimchictl-linux-arm64"
      sha256 "3e3335662a085837b2c6367259a9478d25b6a2b4626654697e1ba09d4c00bb38"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.4/kimchictl-linux-x64"
      sha256 "fee2a0fc6810fa8a00f4c983c8d0fb366ea4572b79137f93ff170aba84945d1e"
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
