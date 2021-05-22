#!/usr/bin/env bash

copyfile() {
    dir=$(dirname "$2")
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    cp -Ru "$1" "$2"
}
