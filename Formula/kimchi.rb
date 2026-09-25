# typed: false
# frozen_string_literal: true

class Kimchi < Formula
  desc "A coding agent CLI powered by Cast AI"
  homepage "https://github.com/castai/kimchi"
  version "1.1.35"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_arm64.tar.gz"
    sha256 "75a842f0a3bf5ee7d744b9e6286038215e98026a73213f0534eff20cd8bce2d5"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_amd64.tar.gz"
    sha256 "ab7fa4007bcbaa87d6d5f3566123682e105907fc104b1f503b769252dcf2f7c1"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_arm64.tar.gz"
    sha256 "f094661ac0c6081fb3e877d10e42d5152d3f5ee644df6c075329c8cac6417489"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_amd64.tar.gz"
    sha256 "77968f2f6d669a3e1189127fbb504ed1ac2c6b1bbf159dd5ae4b6fa06db4897e"
  end

  def install
    bin.install "bin/kimchi"
    (share/"kimchi").install Dir["share/kimchi/*"]
  end

  test do
    system "#{bin}/kimchi", "--version"
  end
end
