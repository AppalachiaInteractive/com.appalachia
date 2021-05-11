#!/bin/bash

shopt -s nullglob

root="${HOME}/com.appalachia"
source "${root}/appa/.apparc"
source "${APPA_COMMAND_HOME}/secrets/export.sh"

if [ "$#" -eq 0 ] ; then
    print_header
    print_commands 
else
    process_commands "$@"
fi
