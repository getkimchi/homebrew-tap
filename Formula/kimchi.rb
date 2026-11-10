# typed: false
# frozen_string_literal: true

class Kimchi < Formula
  desc "A coding agent CLI powered by Cast AI"
  homepage "https://github.com/castai/kimchi"
  version "1.33.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_arm64.tar.gz"
    sha256 "d13108745f09c5f0079f06d7e159b25359c60dafcd271ddbb6ad2cc6f4005d52"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_amd64.tar.gz"
    sha256 "271e84ae7d6b439d6b44007c001f1eed1f715d755d0365a4303fdbc175e505c7"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_arm64.tar.gz"
    sha256 "bb2d476d5ceba6c90c3fd4a55583fcaa3dff55e93060cad59d5e32bc014c8df5"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_amd64.tar.gz"
    sha256 "59ecf7f9d9ab1e1d5ed1d1cba6c27899cf354a392096e2a10e8c7369dea88e12"
  end

  def install
    bin.install "bin/kimchi"
    (share/"kimchi").install Dir["share/kimchi/*"]
  end

  test do
    system "#{bin}/kimchi", "--version"
  end
end
