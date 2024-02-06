#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

make install-gcc
make install-target-libgcc

make -C gmp install
make -C mpfr install
