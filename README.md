# santOS
An operating system developed in Swift.
NOTE: Its still in the very early stages.

Currently the following archs are supported:
* ARMv7


## Build

### Building Compiler Builtins

```bash
git clone https://github.com/llvm/llvm-project.git llvm-project
cd llvm-project/compiler-rt
mkdir build
cd build

export NONE_EABI_TARGET_FLAGS="-mthumb -mfloat-abi=soft -fshort-enums"
export NONE_EABI_TARGET=armv7-none-eabi
export ARM_SYSROOT=$(arm-none-eabi-gcc -print-sysroot)
export LLVM_BIN_PATH=$(dirname $(which clang))

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release \
-DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
-DCOMPILER_RT_OS_DIR="baremetal" \
-DCOMPILER_RT_BUILD_BUILTINS=ON \
-DCOMPILER_RT_BUILD_SANITIZERS=OFF \
-DCOMPILER_RT_BUILD_XRAY=OFF \
-DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
-DCOMPILER_RT_BUILD_PROFILE=OFF \
-DCMAKE_C_COMPILER=/usr/bin/clang \
-DCMAKE_C_COMPILER_TARGET=${NONE_EABI_TARGET} \
-DCMAKE_ASM_COMPILER_TARGET=${NONE_EABI_TARGET} \
-DCMAKE_AR=${LLVM_BIN_PATH}/llvm-ar \
-DCMAKE_NM=${LLVM_BIN_PATH}/llvm-nm \
-DCMAKE_LINKER=${LLVM_BIN_PATH}/ld.lld \
-DCMAKE_RANLIB=${LLVM_BIN_PATH}/llvm-ranlib \
-DCOMPILER_RT_BAREMETAL_BUILD=ON \
-DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
-DLLVM_CONFIG_PATH=${LLVM_BIN_PATH}/llvm-config \
-DCMAKE_C_FLAGS=${NONE_EABI_TARGET_FLAGS} \
-DCMAKE_ASM_FLAGS=${NONE_EABI_TARGET_FLAGS} \
-DCOMPILER_RT_INCLUDE_TESTS=OFF \
-DCMAKE_SYSROOT=${ARM_SYSROOT} ..

# builtins will be stored in compiler-rt/build/lib/baremetal
```


To build the project, run the following commands:
```bash
cd santOS
mkdir build
cd build
cmake -G Ninja ..
ninja uboot
```
