#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

../configure --target=m68k-unknown-elf --with-headers --with-libs --enable-languages=c,c++ --disable-nls --disable-werror --prefix="$PREFIX" --with-gmp="$PREFIX" --with-mpfr="$PREFIX"
