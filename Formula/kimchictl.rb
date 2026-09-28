# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.7/kimchictl-darwin-arm64"
      sha256 "418a4ef69e189d5ed7c95fd9ca59bd5d846705e88137c7e7381bdb592c923e05"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.7/kimchictl-darwin-x64"
      sha256 "e4b84314fd02d2b2ed39afaf012ce7ebeb970d0970562a80c0e286fc4efed313"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.7/kimchictl-linux-arm64"
      sha256 "b7dbcd18179be73ba1996defff74ad6236a6a4fd28ceb71dc1bfaab641640966"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.7/kimchictl-linux-x64"
      sha256 "613e42906bfef437a0430476db68474d70b6fe01905fd3b4a5e53f92989e64e1"
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
