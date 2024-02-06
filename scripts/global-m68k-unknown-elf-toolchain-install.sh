#!/bin/bash

set -e

cat > toolchain-m68k-unknown-elf.cmake <<EOF
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR m68k)

set(CMAKE_C_COMPILER    $PREFIX/bin/m68k-unknown-elf-gcc)
set(CMAKE_C_FLAGS       "-ffreestanding -nostdlib -march=68030 -m68881")
set(CMAKE_CXX_COMPILER  $PREFIX/bin/m68k-unknown-elf-g++)
set(CMAKE_CXX_FLAGS     "-ffreestanding -nostdlib -march=68030 -m68881")
set(CMAKE_ASM_COMPILER  $PREFIX/bin/m68k-unknown-elf-as)
set(CMAKE_ASM_FLAGS     "-march=68030 -m68881")
EOF

if [ -d "$PREFIX/usr/share" ]; then
    ginstall -D -v toolchain-m68k-unknown-elf.cmake "$PREFIX/usr/share/cmake/toolchains/EHBCFreestandingToolchain.cmake"
else
    ginstall -D -v toolchain-m68k-unknown-elf.cmake "$PREFIX/share/cmake/toolchains/EHBCFreestandingToolchain.cmake"
fi
