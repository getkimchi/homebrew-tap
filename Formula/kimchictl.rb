# Kimchictl formula rendered by .github/workflows/release.yml — edit the
# template here, never the generated file in getkimchi/homebrew-tap.
class Kimchictl < Formula
  desc "CLI for kimchi remote workspaces"
  homepage "https://github.com/getkimchi/kimchictl"
  version "0.0.17"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.17/kimchictl-darwin-arm64"
      sha256 "0109e6c3baa2215e818bd5009e43f137016e000aa4a02f8788e649019321e92b"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.17/kimchictl-darwin-x64"
      sha256 "e0d935d4b8c23b5933b224e15944608444a5b03a508be872561692f34b469c80"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.17/kimchictl-linux-arm64"
      sha256 "2e970af17997ed3b9c882ef0772e0f70dc9dec3700274a016a777d56a2834ec0"
    else
      url "https://github.com/getkimchi/kimchictl/releases/download/0.0.17/kimchictl-linux-x64"
      sha256 "df1a2cbab8f65a8ed62e32777c4cc63551ab454e85603f647edef1081e71ffb5"
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
