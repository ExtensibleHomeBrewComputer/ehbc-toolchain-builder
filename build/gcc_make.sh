#!/bin/bash

set -e

./contrib/download_prerequisites

mkdir -p build-m68k-elf
cd build-m68k-elf

if [ ! -f "../.stamp_configured" ]; then
    ../configure --target=m68k-unknown-elf --without-headers --enable-languages=c,c++ --disable-werror --prefix="$PREFIX"
fi

touch ../.stamp_configured
make all-gcc -j8
make all-target-libgcc -j8
make install-gcc
make install-target-libgcc

make -C gmp install
make -C mpfr install
