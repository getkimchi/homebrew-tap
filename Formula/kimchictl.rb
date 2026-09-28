# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.13/kimchictl-darwin-arm64"
      sha256 "9a086fd4c9674f0a69e63b2c60089fd78440ce4f00d9a0704e6d04e511aaea9d"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.13/kimchictl-darwin-x64"
      sha256 "9fd688733182bacb3e81cef328cd441669c4d0118145061cef21b56710823ed5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.13/kimchictl-linux-arm64"
      sha256 "582fafbddf1bb62092bc68dc8fed14879c71ddae0248f6219264c224b0215f94"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.13/kimchictl-linux-x64"
      sha256 "bd5473c50ca85bf612301bd46b3488fd6af17338346b7b5bec79cb333e3e3646"
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
