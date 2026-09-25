# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.6/kimchictl-darwin-arm64"
      sha256 "76bd9b975942e72370a82d5c741a483fcdd8535dc4cebf6cb24a17d2a50c1193"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.6/kimchictl-darwin-x64"
      sha256 "4c12271ab13d6752306f208ca02f5d82d603d68b4e8d137752440dfc3ce4a930"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.6/kimchictl-linux-arm64"
      sha256 "74d6c9b2b876849287c0f4bcb3485b4525325b8701b3a240b104220dc8ad0fa1"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.6/kimchictl-linux-x64"
      sha256 "05aad2500efdb99a6ecf609e79c32ee8d78ed9b1ac5456affa291fcc793c7164"
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
