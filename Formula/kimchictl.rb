# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.26"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.26/kimchictl-darwin-arm64"
      sha256 "2d21b94431cbcbcb8473e9f6d6a59ca80e35b67beaa1f7761089f0478b6868cd"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.26/kimchictl-darwin-x64"
      sha256 "2dbbe3f073c33c54303f97e17bb1cd8dc151d496e0ba50fdb8b58d9cf4eff91a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.26/kimchictl-linux-arm64"
      sha256 "6dbcc76458eadcd401cd9a66fdf6e1bbaabf543c9902e8ffeb9417c37c7eb80b"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.26/kimchictl-linux-x64"
      sha256 "2ba685d4fbddc94ac0362023d83b68e73df4dec76c72dfa818a2984cf8fbf08e"
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
