#!/bin/bash

set -e

../../ehbc-binutils-gdb/configure \
    --target=m68k-unknown-elf \
    --disable-nls \
    --disable-werror \
    --with-sysroot \
    --with-gmp="$PREFIX" \
    --with-mpfr="$PREFIX" \
    --with-mpc="$PREFIX" \
    --prefix="$PREFIX"
