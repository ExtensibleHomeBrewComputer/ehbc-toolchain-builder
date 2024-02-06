#!/bin/bash

set -e

../../ehbc-gcc/configure \
    --target=m68k-unknown-ehbcfw \
    --enable-languages=c,c++ \
    --enable-obsolete \
    --enable-lto \
    --disable-threads \
    --disable-libmudflap \
    --disable-libgomp \
    --disable-nls \
    --disable-werror \
    --disable-libssp \
    --disable-shared \
    --disable-multilib \
    --disable-libgcj \
    --disable-libstdcxx \
    --disable-gcov \
    --without-headers \
    --without-included-gettext \
    --with-newlib \
    --prefix="$PREFIX"

