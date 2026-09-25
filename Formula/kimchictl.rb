# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.2/kimchictl-darwin-arm64"
      sha256 "f67f34b81700ecefe94472b34973f2e2b709b1e72f72a758569b17ea6cc05325"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.2/kimchictl-darwin-x64"
      sha256 "71389f1d89644c7931cdd482b375001417940a312e414d403fd8929bd2cf5cf5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.2/kimchictl-linux-arm64"
      sha256 "399ba0429a822b7eaba2cafb35f9344abc5d80617890e8198683b5c05d431e3f"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.2/kimchictl-linux-x64"
      sha256 "bb8adde964effcd8251be4a7f75159c1dafd89b8c53713af33e2cf179191559e"
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
