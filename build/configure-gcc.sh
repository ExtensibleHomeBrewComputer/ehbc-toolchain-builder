#!/bin/bash

set -e

./contrib/download_prerequisites

mkdir -p build-m68k-elf
cd build-m68k-elf

../configure --target=m68k-unknown-elf --without-headers --enable-languages=c,c++ --disable-werror --prefix="$PREFIX"

