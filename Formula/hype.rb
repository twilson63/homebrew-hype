class Hype < Formula
  desc "Fast Lua runtime for scripting and automation - Node.js alternative for Lua"
  homepage "https://github.com/twilson63/hype-rs"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twilson63/hype-rs/releases/download/v0.4.0/hype-aarch64-apple-darwin.tar.gz"
      sha256 "d31fae39b7e42c1555ad81b994a8494478ef6eef14627a84657bd3ca106d4b78"
    else
      url "https://github.com/twilson63/hype-rs/releases/download/v0.4.0/hype-x86_64-apple-darwin.tar.gz"
      sha256 "c27351848705006605103a04e7ff0c83dabb180bc58f56a597c6d58240e0b7c2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twilson63/hype-rs/releases/download/v0.4.0/hype-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9f6937437fd44a7b03f1c750a5320b2603f2afcc1e65919e0671f994106ba0a8"
    end
  end

  def install
    bin.install "hype"
  end

  test do
    # Test version output
    output = shell_output("#{bin}/hype --version")
    assert_match version.to_s, output

    # Test basic Lua execution
    (testpath/"test.lua").write("print('Hello from Hype!')")
    output = shell_output("#{bin}/hype #{testpath}/test.lua")
    assert_match "Hello from Hype!", output

    # Test require() with builtin module
    (testpath/"json_test.lua").write(<<~LUA)
      local json = require("json")
      local data = {name = "test", value = 42}
      print(json.encode(data))
    LUA
    output = shell_output("#{bin}/hype #{testpath}/json_test.lua")
    assert_match '"name"', output
    assert_match '"value"', output
  end
end
