# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.9/kimchictl-darwin-arm64"
      sha256 "6ca553d57d6ebd679c93b5a61acfaf7adc7f6904a3d3f38ff8d3e0d7e9228ab1"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.9/kimchictl-darwin-x64"
      sha256 "59a46b694dce787b2aa73d25ebc8d2a38a6a8a190b1aa022ae471741a7133e07"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.9/kimchictl-linux-arm64"
      sha256 "8f8a8b5774a81cd13031bba4c0ccb524c39161162f65c5bebe6a4bd21af8a86f"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.9/kimchictl-linux-x64"
      sha256 "b0935b13deb735761de029f8dc2d392e62ade6ee5454221488be06030d864e84"
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
