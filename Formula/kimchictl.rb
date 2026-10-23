# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.25"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.25/kimchictl-darwin-arm64"
      sha256 "f567788ad0ef0e2d1625b7c7b0d3805c26c70d441104e4743624480131c42aa6"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.25/kimchictl-darwin-x64"
      sha256 "d3870d86a30517ae39e809786284b3f3fa366d29dc23cf5e58a3f6a75f42c072"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.25/kimchictl-linux-arm64"
      sha256 "8e2661f2ed5ed0daa5361ebffab46f518d04adf63fa4042b58061c6a2a7816b1"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.25/kimchictl-linux-x64"
      sha256 "7f348cece09d975e6d5e1e15c0cf402f0a47f88c0c74de2f065b317d562dd820"
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
