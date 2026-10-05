# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.18"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.18/kimchictl-darwin-arm64"
      sha256 "618757f8a8049b7dac5f3cda93d737bbbff04872322590c0ee47f1192392847b"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.18/kimchictl-darwin-x64"
      sha256 "f33e2388aa959afbafe32aaf6af8800cfa0c3086818ceb5e366d3d45606e3ecc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.18/kimchictl-linux-arm64"
      sha256 "b4630e112fce0ef5f4772affc4b8ae8a64d4b19de7daa39afe836f2823f43f59"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.18/kimchictl-linux-x64"
      sha256 "2c18cc8940a0230cd4af92540e60e7ded1e0d216283e6ee0075af2b375a491d2"
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
