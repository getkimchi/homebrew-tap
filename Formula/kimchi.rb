# typed: false
# frozen_string_literal: true

class Kimchi < Formula
  desc "A coding agent CLI powered by Cast AI"
  homepage "https://github.com/castai/kimchi"
  version "1.0.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_arm64.tar.gz"
    sha256 "be016a962c0f856e01acd6f4ac71c10686183f3c7763ffcb65e7b96e593d9a78"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_amd64.tar.gz"
    sha256 "d285e4cfecce03fa965a31f9bb085bbeabb5a6cddad96dec3ebc57197a52e3b3"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_arm64.tar.gz"
    sha256 "d04b2b32062e62e3170246a64994bd10af2aada3e744a7bcc0c361b0def8abf5"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_amd64.tar.gz"
    sha256 "8558e91f109eafac82a21a0880a6853873bafed1e1998315e84a4c92ba7e791f"
  end

  def install
    bin.install "bin/kimchi"
    (share/"kimchi").install Dir["share/kimchi/*"]
  end

  test do
    system "#{bin}/kimchi", "--version"
  end
end
