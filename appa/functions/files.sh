#!/usr/bin/env bash

copyfile() {
    dir=$(dirname "$2")
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    cp -R "$1" "$2"
}