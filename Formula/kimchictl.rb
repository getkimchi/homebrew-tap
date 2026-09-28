# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.11/kimchictl-darwin-arm64"
      sha256 "cb32fe22004a2d5972fac51546d10d7b6512497708d2de3e030797aefad28a6a"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.11/kimchictl-darwin-x64"
      sha256 "8696242644cfab6ae8e9068841a6fe1d53a262c7fc373d3272a4cf39f70dbe69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.11/kimchictl-linux-arm64"
      sha256 "fc365a97a08f020f2d7b84aa0e914e5143472a5abb96d50e715ea97ffb3c00f0"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.11/kimchictl-linux-x64"
      sha256 "dab2e5bf9d2b873fef4af3179c343deb2a959c02aac73d67de647efbbaf82f19"
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
