#!/bin/bash

shopt -s nullglob

root="${HOME}/com.appalachia"
source "${root}/appa/.apparc"

check_node
check_python

debug "${config_file}"

if [ "$#" -eq 0 ] ; then
    print_header
    print_commands 
else
    process_commands "$@"
fi
