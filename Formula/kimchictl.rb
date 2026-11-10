# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.27"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.27/kimchictl-darwin-arm64"
      sha256 "c8405bb331061df652f54a48895ee741e07c4d00db82d6b2df83d13961a9ac0c"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.27/kimchictl-darwin-x64"
      sha256 "672f91dc91f0701ad1fd1b62a3d6576eb2da3b58b9b263c4e4b6d7cb748b148d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.27/kimchictl-linux-arm64"
      sha256 "2e63453dbb89454f5c43ad6610fc77b6bafc1903747eb6eba440763a4ff9ee03"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.27/kimchictl-linux-x64"
      sha256 "8891fd8446b4f248a2bb70a7199eb1eab4e2f821b1cb3f5c059b98ff8b89c842"
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
