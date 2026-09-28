# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.12/kimchictl-darwin-arm64"
      sha256 "76aa8a84459bcadc877ef5951d82ebabc91d7b679b0ceb157a6207829c28039c"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.12/kimchictl-darwin-x64"
      sha256 "f7471398b2da9a2d9a2bc79a2855bd8c68d3144067e924d47508bd483261b4cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.12/kimchictl-linux-arm64"
      sha256 "e054aa403111e13cb781653878518a4e4cd1f38e48ec8d98b2bdf6ade840f031"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.12/kimchictl-linux-x64"
      sha256 "93a49af5d118ebb8b95539f870f1ff581c487562f2a114f80d40641a28ddbe58"
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
