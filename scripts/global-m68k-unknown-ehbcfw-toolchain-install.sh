#!/bin/bash

set -e

cat > toolchain-m68k-unknown-ehbcfw.cmake <<EOF
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR m68k)

set(CMAKE_C_COMPILER    $PREFIX/bin/m68k-unknown-ehbcfw-gcc)
set(CMAKE_C_FLAGS       "-march=68030 -m68881")
set(CMAKE_CXX_COMPILER  $PREFIX/bin/m68k-unknown-ehbcfw-g++)
set(CMAKE_CXX_FLAGS     "-march=68030 -m68881")
set(CMAKE_ASM_COMPILER  $PREFIX/bin/m68k-unknown-ehbcfw-as)
set(CMAKE_ASM_FLAGS     "-march=68030 -m68881")
EOF

if [ -d "$PREFIX/usr/share" ]; then
    ginstall -D -v toolchain-m68k-unknown-ehbcfw.cmake "$PREFIX/usr/share/cmake/toolchains/EHBCFirmwareToolchain.cmake"
else
    ginstall -D -v toolchain-m68k-unknown-ehbcfw.cmake "$PREFIX/share/cmake/toolchains/EHBCFirmwareToolchain.cmake"
fi
