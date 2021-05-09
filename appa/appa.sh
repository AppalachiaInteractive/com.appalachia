#!/bin/bash

shopt -s nullglob

root="${HOME}/com.appalachia"
source "${root}/appa/.apparc"

if [ "$#" -eq 0 ] ; then
    print_header
    print_commands 
else
    process_commands "$@"
fi
