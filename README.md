# Homebrew Tap for Hype

Official Homebrew tap for [Hype](https://github.com/twilson63/hype-rs) - a fast Lua runtime for scripting and automation.

## Installation

### Install Hype

```bash
brew install twilson63/hype/hype
```

Or add the tap first:

```bash
brew tap twilson63/hype
brew install hype
```

### Verify Installation

```bash
hype --version
```

## Usage

Create a Lua script:

```lua
-- hello.lua
local json = require("json")
local time = require("time")

local data = {
    message = "Hello from Hype!",
    timestamp = time.toISO(time.now())
}

print(json.encode(data, true))
```

Run it:

```bash
hype hello.lua
```

## What is Hype?

Hype is a fast Lua 5.4 runtime built in Rust, designed as a Node.js alternative for Lua developers. It features:

- ⚡ **Fast startup** (~50ms)
- 📦 **Module system** with `require()` and `hype_modules/`
- 🔐 **Security** features and sandboxing
- 🛠️ **Standard library** (89+ functions)
  - crypto (hashing, bcrypt, HMAC, random)
  - fs (file operations)
  - http (HTTP client)
  - json (encoding/decoding)
  - time (timestamps, formatting)
  - string (text manipulation)
  - url, os, process, and more

## Documentation

- [API Documentation](https://github.com/twilson63/hype-rs/tree/master/docs/api)
- [Quick Reference](https://github.com/twilson63/hype-rs/blob/master/docs/api/QUICK_REFERENCE.md)
- [Examples](https://github.com/twilson63/hype-rs/tree/master/examples)
- [Module System Guide](https://github.com/twilson63/hype-rs/tree/master/docs/modules)

## Supported Platforms

- macOS (Intel and Apple Silicon)
- Linux (x86_64)

## Updating

```bash
brew update
brew upgrade hype
```

## Uninstalling

```bash
brew uninstall hype
brew untap twilson63/hype
```

## Support

- **Issues**: [GitHub Issues](https://github.com/twilson63/hype-rs/issues)
- **Repository**: [twilson63/hype-rs](https://github.com/twilson63/hype-rs)

## License

MIT
