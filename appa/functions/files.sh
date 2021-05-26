#!/usr/bin/env bash

copyfile() {
    dir=$(dirname "$2")
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi

    cp -Ru "$1" "$2"
}

copynewerfile() {
    dir=$(dirname "$2")
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi

    if [[ "$1" -nt "$2" ]]; then cp -Ru "$1" "$2"; fi   
    
}
