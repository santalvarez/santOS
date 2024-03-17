cmake_minimum_required(VERSION 3.28)

set(COMPILE_FOLDER "${CMAKE_SOURCE_DIR}/compile")

set(SANTOS_ELF "santOS.elf")
set(SANTOS_BIN "santOS.bin")
set(SANTOS_IMG "santOS.img")


set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
set(CMAKE_OBJCOPY "arm-none-eabi-objcopy")


set(LINKER_SCRIPT "${COMPILE_FOLDER}/armv7/script.ld")
set(MKIMAGE_PATH "${COMPILE_FOLDER}/tools/mkimage")
set(CMAKE_Swift_COMPILER "/opt/swift/usr/bin/swiftc")

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

set(CMAKE_C_FLAGS "-mcpu=cortex-a8 -mthumb -mfloat-abi=soft")
set(CMAKE_ASM_FLAGS "-mcpu=cortex-a8 -mthumb -mfloat-abi=soft")


set(CMAKE_Swift_FLAGS
    # -wmo: Whole-module optimization is always required for Embedded Swift.
    # -Xfrontend -function-sections: enables dead stripping of unused runtime functions.
    "-target armv7-none-none-eabi \
    -enable-experimental-feature Embedded \
    -wmo \
    -use-ld=/usr/bin/arm-none-eabi-ld \
    -Xcc -mthumb \
    -Xcc -mcpu=cortex-a8 \
    -Xcc -fshort-enums \
    -Xcc -mfloat-abi=soft \
    -Xfrontend -function-sections \
    -import-objc-header ${CMAKE_SOURCE_DIR}/include/bridge.h"
)

# Disable CMake’s automatic Swift compiler check. The compiler check always
# fails for Embedded Swift because it tries to compile a Swift program that
# includes `print()`, which isn't available in Embedded Swift.
set(CMAKE_Swift_COMPILER_FORCED TRUE)


project(santOS LANGUAGES Swift C ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories("${CMAKE_SOURCE_DIR}/include")

# Build ELF
add_executable(${SANTOS_ELF}
               ${CMAKE_SOURCE_DIR}/kern/start.S
               ${CMAKE_SOURCE_DIR}/kern/interrupt.S
               ${CMAKE_SOURCE_DIR}/lib/libc/libc_hooks.c
               ${CMAKE_SOURCE_DIR}/lib/posix_memalign.c
               ${CMAKE_SOURCE_DIR}/lib/arc4random.c
               ${CMAKE_SOURCE_DIR}/lib/putchar.c
               ${CMAKE_SOURCE_DIR}/kern/putc.swift
               ${CMAKE_SOURCE_DIR}/kern/init.swift)
target_link_libraries(${SANTOS_ELF}
                      PRIVATE "-L${CMAKE_SOURCE_DIR}/compile/armv7/lib"
                      PRIVATE "-L/usr/lib/arm-none-eabi/newlib"
                      PRIVATE "-Xlinker -T${LINKER_SCRIPT}")

# using objcopy, convert elf to binary
add_custom_command(
    OUTPUT ${SANTOS_BIN}
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${SANTOS_ELF}> ${SANTOS_BIN}
    DEPENDS ${SANTOS_ELF}
    COMMENT "Converting ELF to binary"
)

# build uboot image
add_custom_target(uboot
    COMMAND ${CMAKE_COMMAND} -E echo "Making santOS uboot image ..."
    COMMAND ${MKIMAGE_PATH} -A arm -O linux -T kernel -C none -a 0x81000000 -e 0x81000000 -n 'santOS' -d ${SANTOS_BIN} ${SANTOS_IMG}
    DEPENDS ${SANTOS_BIN}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)

