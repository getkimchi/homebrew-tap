# typed: false
# frozen_string_literal: true

class Kimchi < Formula
  desc "A coding agent CLI powered by Cast AI"
  homepage "https://github.com/castai/kimchi"
  version "1.5.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_arm64.tar.gz"
    sha256 "9c4b4a849b393b0f60d152380b29f8664d0b75722e143c5ec5a6f474495a20cb"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_amd64.tar.gz"
    sha256 "ffab8b9dff55779ab600d16db4db0f07c6b9eef3f4b4c285342b36d17225ad1e"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_arm64.tar.gz"
    sha256 "bcb36a1d63bb1183fbbde83f47c89ea5c08d0a84258d0a6d6059e3f6277a0d40"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_amd64.tar.gz"
    sha256 "cdac1dd35750ec60d291bfb3c75ad85f46f01b6ddb1c3585f3518ac75c96f8ba"
  end

  def install
    bin.install "bin/kimchi"
    (share/"kimchi").install Dir["share/kimchi/*"]
  end

  test do
    system "#{bin}/kimchi", "--version"
  end
end
