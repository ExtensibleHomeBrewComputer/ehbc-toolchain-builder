#!/bin/bash

set -e

cd build/m68k-unknown-elf-gcc

make -C gmp install
make -C mpfr install
make -C mpc install
