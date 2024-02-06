#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

../configure \
    --target=m68k-unknown-elf \
    --disable-newlib-multithread \
    --enable-lite-exit \
    --disable-newlib-supplied-syscalls \
    --prefix="$PREFIX"

