#!/bin/bash

set -e

make CPU=m68k SYNTAX=mot
ginstall -D -v vasmm68k_mot "$PREFIX/bin/vasmm68k_mot"
