#!/bin/bash

set -e

../../binutils-gdb/configure \
    --target=m68k-unknown-ehbcfw \
    --disable-nls \
    --disable-werror \
    --with-sysroot \
    --with-gmp="$PREFIX" \
    --with-mpfr="$PREFIX" \
    --with-mpc="$PREFIX" \
    --prefix="$PREFIX"
