# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.8/kimchictl-darwin-arm64"
      sha256 "9c48f983e524288e04ab8ffcf1a2bc29ffbd88c7e17eb9e86cce38b9dc47ad41"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.8/kimchictl-darwin-x64"
      sha256 "bebb533ffa590f03c179a74b077892ae95695177f326a38401a5dd6579b53f41"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.8/kimchictl-linux-arm64"
      sha256 "453a1b762bdc3836afc4fb921f8633647a66e96c1729b931886a7b21bf8bbab3"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.8/kimchictl-linux-x64"
      sha256 "33ead6feb5b66aebc7f0d4a3567eacf89873f983dd71fb03cb8e6bf3f7ccb24d"
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
