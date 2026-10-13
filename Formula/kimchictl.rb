# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.21"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.21/kimchictl-darwin-arm64"
      sha256 "751057db8cacadbf9e6d4ff224cc9b17ee325eea73f21140336e58f3bc0e237f"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.21/kimchictl-darwin-x64"
      sha256 "853fa7f033354840819894d428baa348b3f167050ab3f2d895b003164ddba4c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.21/kimchictl-linux-arm64"
      sha256 "5fa0df71ecc37956f22c01ee122add524648f880e0d45ec9441fa2efb05df168"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.21/kimchictl-linux-x64"
      sha256 "70fc21793d92ba1bcce65dec8f3f91b3adeff88bedd97f7a6d1f063d335fb283"
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
