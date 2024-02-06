#!/bin/bash

MAKE_STEPS=(
    "binutils   fetch   https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz"
    "gcc        fetch   https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz"
    "gdb        fetch   https://ftp.gnu.org/gnu/gdb/gdb-14.1.tar.xz"
    "newlib     fetch   ftp://sourceware.org/pub/newlib/newlib-4.4.0.20231231.tar.gz"
    "binutils   configure"
    "binutils   compile"
    "binutils   install"
    "gcc        configure"
    "gcc        compile"
    "newlib     configure"
    "newlib     compile"
    "newlib     install"
    "gcc        configure"
    "gcc        compile"
    "gcc        install"
    "gdb        configure"
    "gdb        compile"
    "gdb        install"
)
