#!/bin/bash

set -e

mkdir -p build-m68k-elf
cd build-m68k-elf

make -j8

cd ../..

rm .gcc.configurestamp
rm .gcc.compilestamp
