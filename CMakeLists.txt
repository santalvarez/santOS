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

set(CMAKE_Swift_FLAGS
    # -wmo: Whole-module optimization is always required for Embedded Swift.
    # -Xfrontend -function-sections: enables dead stripping of unused runtime functions.
    "-target armv7-none-none-eabi \
    -enable-experimental-feature Embedded \
    -wmo \
    -use-ld=/usr/bin/arm-none-eabi-ld \
    -parse-stdlib \
    -Xcc -fshort-enums \
    -Xcc -mfloat-abi=soft \
    -Xlinker --script=${LINKER_SCRIPT} \
    -Xfrontend -function-sections"
)

# Disable CMake’s automatic Swift compiler check. The compiler check always
# fails for Embedded Swift because it tries to compile a Swift program that
# includes `print()`, which isn't available in Embedded Swift.
set(CMAKE_Swift_COMPILER_FORCED TRUE)


project(santOS LANGUAGES Swift C ASM)
set(CMAKE_C_STANDARD 11)

include_directories("${CMAKE_SOURCE_DIR}/include")

# build elf using object files
add_executable(${SANTOS_ELF}
               ${CMAKE_SOURCE_DIR}/kern/start.S
               ${CMAKE_SOURCE_DIR}/kern/init.swift)
# add library path to linker
target_link_libraries(${SANTOS_ELF} PRIVATE "-L${CMAKE_SOURCE_DIR}")

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

