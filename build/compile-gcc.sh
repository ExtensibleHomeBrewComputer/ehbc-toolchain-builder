#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

make all-gcc -j8
make all-target-libgcc -j8
