cmake_minimum_required(VERSION 3.28)


set(SANTOS_ELF "santOS.elf")
set(SANTOS_BIN "santOS.bin")
set(SANTOS_IMG "santOS.img")

set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
set(CMAKE_ASM_COMPILER "arm-none-eabi-as")
set(CMAKE_OBJCOPY "arm-none-eabi-objcopy")


set(MKIMAGE_PATH "tools/mkimage")

set(CMAKE_Swift_COMPILER "/opt/swift/usr/bin")

set(CMAKE_Swift_FLAGS
    # -wmo: Whole-module optimization is always required for Embedded Swift.
    # -Xfrontend -function-sections: enables dead stripping of unused runtime functions.
    "-target armv7a-none-none-eabi \
    -enable-experimental-feature Embedded \
    -wmo \
    -Xfrontend -function-sections"
)

# Disable CMake’s automatic Swift compiler check. The compiler check always 
# fails for Embedded Swift because it tries to compile a Swift program that 
# includes `print()`, which isn't available in Embedded Swift.
set(CMAKE_Swift_COMPILER_FORCED TRUE)

project(santOS LANGUAGES Swift C ASM)

set(CMAKE_C_STANDARD 11)


# build binary



# convert binary to elf



# build uboot image
add_custom_target(santOS
    COMMAND ${CMAKE_COMMAND} -E echo "Making santOS image ..."
    COMMAND ${MKIMAGE_PATH} -A arm -O linux -T kernel -C none -a 0x81000000 -e 0x81000000 -n 'santOS' -d ${SANTOS_BIN} ${SANTOS_IMG}
    DEPENDS ${SANTOS_BIN}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)

