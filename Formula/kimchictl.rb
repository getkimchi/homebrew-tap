# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.16/kimchictl-darwin-arm64"
      sha256 "3e1aa0b7fd11bd331d198c1d452fc687af8eeae00362e1a7cb853fa5cfa6d72e"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.16/kimchictl-darwin-x64"
      sha256 "1f7edf978ea8ec6c6ad523a53363478bcf71a856128a6bd43c40c4e4bff8fe14"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.16/kimchictl-linux-arm64"
      sha256 "da0666aa6e84903e9722a76c5dc6790c3f63a73aa5b474fdbe59bbf6fa339186"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.16/kimchictl-linux-x64"
      sha256 "300968dee1baea3f2440d937ab1c7b328ee84185c80a41e08139a010781536e5"
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
