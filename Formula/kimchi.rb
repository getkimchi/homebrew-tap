# typed: false
# frozen_string_literal: true

class Kimchi < Formula
  desc "A coding agent CLI powered by Cast AI"
  homepage "https://github.com/castai/kimchi"
  version "0.0.89"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_arm64.tar.gz"
    sha256 "bf30aedcd79a53f8d28ff3c921667ec292c425a3f5b4ec31afe84db1b8f44a27"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_darwin_amd64.tar.gz"
    sha256 "a27ae6a66c23be8c31db4aed11db9f618a510d8f226c8d042cb39e01765149c8"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_arm64.tar.gz"
    sha256 "84e05b4838ee337a2193b7f962257b7b900b52541b41a6b0a605a3e20e41e851"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/castai/kimchi/releases/download/v#{version}/kimchi_linux_amd64.tar.gz"
    sha256 "c838cab8d0119897d2de6b40f8dee6fb37fda3c0f4a2030b4b952f7d0883e077"
  end

  def install
    bin.install "bin/kimchi"
    (share/"kimchi").install Dir["share/kimchi/*"]
  end

  test do
    system "#{bin}/kimchi", "--version"
  end
end
