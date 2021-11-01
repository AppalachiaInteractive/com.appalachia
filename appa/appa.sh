#!/bin/bash

shopt -s nullglob

root="${HOME}/com.appalachia"

if [[ "${APPA_LOAD_BASHRC}" == "1" ]]; then
    source "${root}/appa/.bashrc"
else    
    source "${root}/appa/.apparc"
fi

if [ "$#" -eq 0 ] ; then
    print_header
    print_commands 
else
    process_commands "$@"
fi
