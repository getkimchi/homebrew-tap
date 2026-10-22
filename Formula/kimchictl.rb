# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.23"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.23/kimchictl-darwin-arm64"
      sha256 "4c23411edb208b1ff1cd0e0357a78b8d302b97126b40e81c3f80665bdaa1afa1"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.23/kimchictl-darwin-x64"
      sha256 "0e3ff7236c35bd4dd70743f2f69eb858b334a6a4270dd31d0bddebc00eb4c674"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.23/kimchictl-linux-arm64"
      sha256 "5919dd812d8a2d3e76c1853536ec5851a6d7b08f1ae866dd71048eb811e8f06c"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.23/kimchictl-linux-x64"
      sha256 "12654c0113cd70f4be59b4de1e63dfcbf456e70ea5dc67a23f0b557541686bde"
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
