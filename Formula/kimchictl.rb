# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.14/kimchictl-darwin-arm64"
      sha256 "c8b734de36d4a6f4cb31c1c22467fcab87f398b6cac15a413d5c60f258b9b798"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.14/kimchictl-darwin-x64"
      sha256 "4192b726e0f42c823a695bfa8c12b79007ef6c27755769d45ed31532cbf0c055"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.14/kimchictl-linux-arm64"
      sha256 "98c55857ba9d5a143168c065ebcf21e05a7ae567a2bef660c201dbf15fe23eb2"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.14/kimchictl-linux-x64"
      sha256 "5addf826edd5de56dcbfc2d7b635a807071683a395731c6f16dbd1e46245c43a"
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
