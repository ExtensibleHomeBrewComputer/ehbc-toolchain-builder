#!/bin/bash

set -e

TOOLCHAINS=(
    "vasm       http://phoenix.owl.de/tags/vasm1_7.tar.gz"
    "binutils   https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz"
    "gcc        https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz"
    "gdb        https://ftp.gnu.org/gnu/gdb/gdb-14.1.tar.xz"
)

make_sysroot() {
    local path="$1"

    mkdir -p "$path/bin"
    mkdir -p "$path/include"
    mkdir -p "$path/lib"
    mkdir -p "$path/usr"
    mkdir -p "$path/usr/bin"
    mkdir -p "$path/usr/include"
    mkdir -p "$path/usr/lib"
}

download_tarball() {
    local url="$1"
    local toolchain_name="$2"

    echo -n "Downloading source of $toolchain_name... "
    if [ -f "$TARBALL_PATH/$toolchain_name.fetch" ]; then
        echo -e "\033[1;34mSkipped\033[0m"
    else
        echo -n "Downloading from $url "
        wget "$url" -O "$TARBALL_PATH/$toolchain_name.fetch"
        echo -e "\033[1;32mDone\033[0m"
    fi

    if [ -d "$BUILD_PATH/$toolchain_name" ]; then
        echo -e "\033[1;34mSkipped\033[0m"
    else
        echo -n "Extracting $toolchain_name.fetch "
        mkdir -p "$BUILD_PATH/$toolchain_name"
        tar -zxvf "$TARBALL_PATH/$toolchain_name.fetch" -C "$BUILD_PATH/$toolchain_name" --strip-components=1
        echo -e "\033[1;32mDone\033[0m"
    fi
}

compile_binaries() {
    local toolchain_name="$1"
    
    echo "Compiling binaries for $toolchain_name"
    cd "$BUILD_PATH/${toolchain_name}"

    if [ -f "$BUILD_PATH/${toolchain_name}_make.sh" ]; then
        source "$BUILD_PATH/${toolchain_name}_make.sh"
    else
        echo -e "\033[1;31mError: Script file $BUILD_PATH/${toolchain_name}_make.sh is not found.\033[0m"
        exit 1
    fi
}

if [ -z "$PREFIX" ]; then
    prefix_tmp=
    echo -n "\$PREFIX=[${HOME}/.local] "
    read -r prefix_tmp
    if [ -z "$PREFIX" ]; then
        prefix_tmp="${HOME}/.local"
    fi
    export PREFIX="$prefix_tmp"
fi

ROOT_PATH=$(cd "$(dirname -- "$0")"; pwd)

BUILD_PATH="$ROOT_PATH/build"
TARBALL_PATH="$ROOT_PATH/downloads"

INSTALL_PATH="$PREFIX"

mkdir -p "$BUILD_PATH"
mkdir -p "$TARBALL_PATH"

make_sysroot "$INSTALL_PATH"

cd "$DOWNLOAD_PATH"

for toolchain in "${TOOLCHAINS[@]}"; do
    args=()
    for arg in $toolchain; do
        args+=("$arg")
    done
    toolchain_name="${args[0]}"
    url="${args[1]}"

    download_tarball "$url" "$toolchain_name"
    compile_binaries "$toolchain_name"
done

echo "Toolchain built successfully."
