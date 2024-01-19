#!/bin/bash

set -e

DOWNLOAD_STATUS=()
EXTRACT_STATUS=()
CONFIGURE_STATUS=()
COMPILE_STATUS=()
INSTALL_STATUS=()

ROOT_PATH=$(cd "$(dirname -- "$0")"; pwd)
BUILD_PATH="$ROOT_PATH/build"
TARBALL_PATH="$ROOT_PATH/downloads"

mkdir -p "$BUILD_PATH"
mkdir -p "$TARBALL_PATH"

source "$ROOT_PATH/config.sh"

if [ -z "$PREFIX" ]; then
    export PREFIX="${HOME}/.local"
fi

make_sysroot_dirs() {
    local path="$1"

    mkdir -p "$path"
    mkdir -p "$path/bin"
    mkdir -p "$path/include"
    mkdir -p "$path/lib"
    mkdir -p "$path/usr"
    mkdir -p "$path/usr/bin"
    mkdir -p "$path/usr/include"
    mkdir -p "$path/usr/lib"
}

download_tarball() {
    local source_name="$1"
    local url="$2"

    echo -n "Downloading $source_name tarball... "
    if [ -f "$TARBALL_PATH/$source_name.fetch" ]; then
        echo -e "\033[1;34mSkipped\033[0m"
        DOWNLOAD_STATUS+=("\033[1;34mSkipped\033[0m")
    else
        echo -n "Downloading from $url "
        wget "$url" -O "$TARBALL_PATH/$source_name.fetch"
        echo -e "\033[1;32mDone\033[0m"
        DOWNLOAD_STATUS+=("\033[1;32mDone\033[0m")
    fi

    return 0
}

extract_source() {
    local source_name="$1"

    echo -n "Extracting $source_name tarball... "

    if [ ! -f "$TARBALL_PATH/$source_name.fetch" ]; then
        echo -e "\033[1;31mError: File '$TARBALL_PATH/$source_name.fetch' does not exist\033[0m"
        EXTRACT_STATUS+=("\033[1;31mError: File '$TARBALL_PATH/$source_name.fetch' does not exist\033[0m")
        return 1
    elif [ -d "$BUILD_PATH/$source_name" ]; then
        echo -e "\033[1;34mSkipped\033[0m"
        EXTRACT_STATUS+=("\033[1;34mSkipped\033[0m")
    else
        mkdir -p "$BUILD_PATH/$source_name"
        tar -zxvf "$TARBALL_PATH/$source_name.fetch" -C "$BUILD_PATH/$source_name" --strip-components=1
        echo -e "\033[1;32mDone\033[0m"
        EXTRACT_STATUS+=("\033[1;32mDone\033[0m")
    fi

    return 0
}

configure_source() {
    local source_name="$1"
    
    echo -n "Configuring $source_name..."
    cd "$BUILD_PATH/${source_name}"

    if [ ! -d "$BUILD_PATH/$source_name" ]; then
        echo -e "\033[1;31mError: Source directory '$BUILD_PATH/$source_name' does not exist\033[0m"
        CONFIGURE_STATUS+=("\033[1;31mError: Source directory '$BUILD_PATH/$source_name' does not exist\033[0m")
        return 1
    elif [ -f "$BUILD_PATH/.$source_name.cfgstamp" ]; then
        echo -e "\033[1;34mSkipped\033[0m"
        CONFIGURE_STATUS+=("\033[1;34mSkipped\033[0m")
    elif [ -f "$BUILD_PATH/configure-${source_name}.sh" ]; then
        source "$BUILD_PATH/configure-${source_name}.sh"
        touch "$BUILD_PATH/.$source_name.cfgstamp"
        echo -e "\033[1;32mDone\033[0m"
        CONFIGURE_STATUS+=("\033[1;32mDone\033[0m")
    else
        echo -e "\033[1;34mSkipped\033[0m"
        CONFIGURE_STATUS+=("\033[1;34mSkipped\033[0m")
    fi

    return 0
}

compile_source() {
    local source_name="$1"
    
    echo -n "Compiling $source_name..."
    cd "$BUILD_PATH/${source_name}"

    if [ ! -d "$BUILD_PATH/$source_name" ]; then
        echo -e "\033[1;31mError: Source directory '$BUILD_PATH/$source_name' does not exist\033[0m"
        COMPILE_STATUS+=("\033[1;31mError: Source directory '$BUILD_PATH/$source_name' does not exist\033[0m")
        return 1
    elif [ -f "$BUILD_PATH/compile-${source_name}.sh" ]; then
        source "$BUILD_PATH/compile-${source_name}.sh"
        echo -e "\033[1;32mDone\033[0m"
        COMPILE_STATUS+=("\033[1;32mDone\033[0m")
    else
        echo -e "\033[1;31mError: Script file $BUILD_PATH/compile-${source_name}.sh is not found.\033[0m"
        return 1
    fi

    return 0
}

install_source() {
    local source_name="$1"
    
    echo -n "Installing $source_name..."
    cd "$BUILD_PATH/${source_name}"

    if [ ! -d "$BUILD_PATH/$source_name" ]; then
        echo -e "\033[1;31mError: Source directory '$BUILD_PATH/$source_name' does not exist\033[0m"
        INSTALL_STATUS+=("\033[1;31mError: Source directory '$BUILD_PATH/$source_name' does not exist\033[0m")
        return 1
    elif [ -f "$BUILD_PATH/.$source_name.inststamp" ]; then
        echo -e "\033[1;34mSkipped\033[0m"
        INSTALL_STATUS+=("\033[1;34mSkipped\033[0m")
    elif [ -f "$BUILD_PATH/install-${source_name}.sh" ]; then
        source "$BUILD_PATH/install-${source_name}.sh"
        echo -e "\033[1;32mDone\033[0m"
        touch "$BUILD_PATH/.$source_name.inststamp"
        INSTALL_STATUS+=("\033[1;32mDone\033[0m")
    else
        echo -e "\033[1;34mSkipped\033[0m"
        INSTALL_STATUS+=("\033[1;34mSkipped\033[0m")
    fi

    return 0
}

show_statistics() {
    i=0
    for source in "${SOURCES[@]}"; do
        if [ "$i" = 0 ]; then
            printf "Source Name Download \tExtract \tConfigure \tBuild \tInstall\n"
        fi

        args=()
        for arg in $source; do
            args+=("$arg")
        done
        source_name="${args[0]}"

        printf "%-20b \t %-20b\t %-20b\t %-20b\t %-20b \t%-20b\n" "$source_name" "${DOWNLOAD_STATUS[i]}" "${EXTRACT_STATUS[i]}" "${CONFIGURE_STATUS[i]}" "${COMPILE_STATUS[i]}" "${INSTALL_STATUS[i]}"

        ((i++))
    done | column -t -s $'\t'
}

make_sysroot_dirs "$PREFIX"

for source in "${SOURCES[@]}"; do
    args=()
    for arg in $source; do
        args+=("$arg")
    done
    source_name="${args[0]}"
    source_url="${args[1]}"

    download_tarball    "$source_name" "$source_url"
    extract_source      "$source_name"
    configure_source    "$source_name"
    compile_source      "$source_name"
    install_source      "$source_name"
done

show_statistics
