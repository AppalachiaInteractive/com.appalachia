#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ $# -lt 2 ] ; then
    argserror 'Need to provide a test string and font.  Use `showoff` or `test` to figure out your font.'
    exit 2
fi

message=$1
shift
font=$1
shift
figlet "${message}" -f "${font}" "$@"