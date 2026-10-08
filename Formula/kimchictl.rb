# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.19"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.19/kimchictl-darwin-arm64"
      sha256 "12f7cd7dff1a3f5097e0096e32d2aefd4bf3e81669b2ef4436b015bac750dd12"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.19/kimchictl-darwin-x64"
      sha256 "361d99162ec2a1cbb3601b7fda172a9fbcbde84d74e0e78dbcbb006609685441"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.19/kimchictl-linux-arm64"
      sha256 "e303a7ae74fc5a32217daf1dc98ce15bc8038f9713b2d42c4d1c15291c8e1694"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.19/kimchictl-linux-x64"
      sha256 "1026fcc3c97a08e27881704ff2b5feea08107feea3c6b19fd4785f2b6a872b98"
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
