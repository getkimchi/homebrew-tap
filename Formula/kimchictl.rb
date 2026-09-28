# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.10/kimchictl-darwin-arm64"
      sha256 "6cb66180effb4050ab4d1072ac722cf355aeefe0f97c4baa879cc819f2df62d5"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.10/kimchictl-darwin-x64"
      sha256 "f572a7a522ddaeeadffbd4dda14c5800b5337278e1020d7af7d05efefd13a5de"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.10/kimchictl-linux-arm64"
      sha256 "859453f82ac4dc3931f25c035d3c3822f10dd374e042cd69b517c3ee922cdadc"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.10/kimchictl-linux-x64"
      sha256 "e42bb8090abe9c7105f0e7b29ec7b5ea2d7594e32f52032571f2cf5534a25717"
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
