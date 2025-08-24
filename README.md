# santOS
Operating system written in Swift.

## Build
Install swiftly from [here](https://www.swift.org/blog/introducing-swiftly_10/).

```bash
swiftly install main-snapshot-2025-08-21
swiftly use main-snapshot-2025-08-21
```

Install arm toolchain
```bash
brew install arm-none-eabi-gcc
```
Install qemu
```bash
brew install qemu
```

Build the kernel with:

```bash
swift build -c release --triple armv7-none-none-eabi --toolset toolset.json
```

Run in qemu (currently this only print a hello world!)
```bash
qemu-system-arm -M virt,highmem=off -cpu cortex-a15 -m 512M -nographic -serial mon:stdio -device loader,file=.build/armv7-none-none-eabi/release/santOS,cpu-num=0  
```

