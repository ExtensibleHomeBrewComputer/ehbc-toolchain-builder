#!/bin/bash

set -e

meson setup \
    -Ddefault_library=static \
    -Dprefix="$PREFIX" \
    -Ddisable_linux_option=true \
    --cross-file ../../scripts/m68k-unknown-ehbcfw.txt \
    . ../../ehbc-mlibc
