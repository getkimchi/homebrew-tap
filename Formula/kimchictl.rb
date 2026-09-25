# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.5/kimchictl-darwin-arm64"
      sha256 "24f9660653e4058e6a1dde92c7b5cb3e12c3aa9400d0d5cfc24c821c016ac64d"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.5/kimchictl-darwin-x64"
      sha256 "9759ac8fc52e25693e33fd0e905d478f2dad57683634a88715e407d038e0e2b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.5/kimchictl-linux-arm64"
      sha256 "3bf276cd030da9e034b307fd2b4fa018ef7e147d2f7edd7010e83dbbe531a22c"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.5/kimchictl-linux-x64"
      sha256 "4bf453639503be2b07aa3063091d9c1fffa5f924a888960fc597f2434447d828"
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
