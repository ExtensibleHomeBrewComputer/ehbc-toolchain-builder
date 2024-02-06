#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

../configure --host=m68k-unknown-elf --target=m68k-unknown-elf --without-cxx --without-ada --prefix="$PREFIX"
