#!/bin/bash

shopt -s nullglob

source_env()
{    
    source "${0%/*}/config/default.sh"
    if [ -d "./.venv" ] ; then source ./.venv/Scripts/activate; else source $APPA_HOME/.venv/Scripts/activate; fi;
}
source_functions()
{  
    functions=(`find "$APPA_FUNCTIONS_HOME" -mindepth 1 -type f -name '*.sh'`)
    for function in ${functions[@]}; do source "$function"; done;
}

source_env
source_functions
check_node
check_python

if [ "$#" -eq 0 ] ; then
    print_header
    print_commands 
else
    process_commands "$@"
fi
