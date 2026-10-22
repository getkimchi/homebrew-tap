# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.22"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.22/kimchictl-darwin-arm64"
      sha256 "d2e5f84beda966bcd86c471d8de520162592046e8f5ca06ec5b7bcde03aac383"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.22/kimchictl-darwin-x64"
      sha256 "37eec157122028f5693658fd24a9fe7cdfa11e838d3518cc3bb76cebb2609744"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.22/kimchictl-linux-arm64"
      sha256 "7c699181026ae9e5aa449a5ce4a2d301184b9dbfb3f4e55d4334ec160710814c"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.22/kimchictl-linux-x64"
      sha256 "ccacc6042e8dcd002a87e538587aab96359475173b539edac0ea7933c8d9b9cb"
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
