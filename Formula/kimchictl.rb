# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.15/kimchictl-darwin-arm64"
      sha256 "d39a6f2d81a2946aad40c050da3968bd0f6727d359a96da4c06de142ebcb2034"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.15/kimchictl-darwin-x64"
      sha256 "73e4349335006a6801f87dc59ab62f01b9a00d397f6fba6449cf5b1a1338bc42"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.15/kimchictl-linux-arm64"
      sha256 "dc08a5becde4336f259a2a03c2ab6963c80baacc4b437091b754af01191a8817"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.15/kimchictl-linux-x64"
      sha256 "6b08d4cd3ceabfd83a3ede31a3f0a478fa80b90cd78dbaec3dc586422828ed4c"
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
