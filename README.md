# santOS
Operating system written in Swift.

## Build
Install swiftly from [here](https://www.swift.org/blog/introducing-swiftly_10/).

```bash
swiftly install main-snapshot-2025-06-22
swiftly use main-snapshot-2025-06-22
```

Build the kernel with:

```bash
swift build -c release --triple armv7-none-none-eabi --toolset toolset.json
```
