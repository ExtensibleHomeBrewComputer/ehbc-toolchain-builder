#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

if [ ! -f "../.stamp_configured" ]; then
    ../configure --target=m68k-unknown-elf --disable-nls --disable-werror --prefix="$PREFIX"
fi

touch ../.stamp_configured
make -j8
make install
