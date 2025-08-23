# santOS
Operating system written in Swift.

## Build
Install swiftly from [here](https://www.swift.org/blog/introducing-swiftly_10/).

```bash
swiftly install main-snapshot-2025-06-22
swiftly use main-snapshot-2025-06-22
```

Install arm toolchain
```bash
brew install arm-none-eabi-gcc
```

Build the kernel with:

```bash
swift build -c release --triple armv7-none-none-eabi --toolset toolset.json
```

Run 
```bash
qemu-system-arm \
  -M virt \
  -cpu cortex-a15 \
  -m 512M \
  -nographic \
  -kernel santOS \
  -append "console=ttyAMA0,115200 earlyprintk"
```

