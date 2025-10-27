class Hype < Formula
  desc "Fast Lua runtime for scripting and automation - Node.js alternative for Lua"
  homepage "https://github.com/twilson63/hype-rs"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twilson63/hype-rs/releases/download/v0.4.1/hype-aarch64-apple-darwin.tar.gz"
      sha256 "c2512b2751511fb2ccfa0652ab2d463f90baef5a7b929d7037916d56a7876077"
    else
      url "https://github.com/twilson63/hype-rs/releases/download/v0.4.1/hype-x86_64-apple-darwin.tar.gz"
      sha256 "306af3275464f1b954c06c8d3e2488c0706257a5d4ca508fcd39a46fdcf346eb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twilson63/hype-rs/releases/download/v0.4.1/hype-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eea29c0f83ebe79d931ad152e13ace00a6dabc800a1ebcf7291c79523a7b9bf3"
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

    # Test HTTP module (critical fix in v0.4.1)
    (testpath/"http_test.lua").write(<<~LUA)
      local http = require("http")
      print("HTTP module loaded successfully")
    LUA
    output = shell_output("#{bin}/hype #{testpath}/http_test.lua")
    assert_match "HTTP module loaded successfully", output
  end
end
