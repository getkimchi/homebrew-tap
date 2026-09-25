# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.3/kimchictl-darwin-arm64"
      sha256 "53f1d66c9bb531e757fd02ad678c03747f71465863fdeb8ed2ce31dc129b6589"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.3/kimchictl-darwin-x64"
      sha256 "e1a1bdfb3d5709458e8808b7e19b6ee7e2529610d1bd7e871ad34532d0be52f5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.3/kimchictl-linux-arm64"
      sha256 "f6c0e0930c0a589cc8abad96eb4f1809e1d7f58f99faec810d0940d997367699"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.3/kimchictl-linux-x64"
      sha256 "2d5afb2f2ba7d989f79eda94b70154729ee1ae6c0cbf71f6f33d25d78a8dc1cb"
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
