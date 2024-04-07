
SRC_ROOT := $(shell pwd)
BUILD_ROOT := $(SRC_ROOT)/.build/release

ARCH := armv7
TARGET := $(ARCH)-none-none-eabi

SWIFT_BIN_PATH := /Library/Developer/Toolchains/swift-6.0-DEVELOPMENT-SNAPSHOT-2024-03-26-a.xctoolchain/usr/bin

LINKER := /opt/homebrew/bin/arm-none-eabi-ld

SWIFT_BUILD := $(SWIFT_BIN_PATH)/swift-build
CLANG := $(SWIFT_BIN_PATH)/clang
MKIMAGE := $(SRC_ROOT)/compile/tools/mkimage

SANTOS_ELF := $(BUILD_ROOT)/santOS.elf
SANTOS_BIN := $(BUILD_ROOT)/santOS.bin
SANTOS_IMG := $(BUILD_ROOT)/santOS.img

LINKER_SCRIPT := $(SRC_ROOT)/compile/armv7/script.ld

.PHONY: build
build:
	@echo "Building static library"
	$(SWIFT_BUILD) \
		-v \
		--configuration release \
		--triple $(TARGET)

.PHONY: link
link:
	@echo "Linking"
	$(LINKER) $(BUILD_ROOT)/libsantOS.a -o $(SANTOS_ELF) \
		-T$(LINKER_SCRIPT) \
		-L$(SRC_ROOT)/compile/armv7/lib

.PHONY: uboot
uboot:
	@echo "Creating u-boot image"
	$(MKIMAGE) -A arm -O linux -T kernel -C none -a 0x81000000 -e 0x81000000 -n 'santOS' -d $(SANTOS_BIN) $(SANTOS_IMG)

.PHONY: clean
clean:
	@echo "cleaning..."
	@rm -rf .build
