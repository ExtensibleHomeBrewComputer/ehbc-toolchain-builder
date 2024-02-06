#!/bin/bash

set -e

make all-gcc -j8
make all-target-libgcc -j8
