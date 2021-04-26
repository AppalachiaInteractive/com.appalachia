#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ $# -eq 0 ] ; then
    error "Must specify at least one argument for packaging."
    exit 1
fi

note "Executing packaging ${C_FUNC}${1}..."

python -m 'appapy' packaging "$@"

res=$?
if [ $res -eq 0 ]
then
    #rm -- "$0"
    success "Packaging ${1} completed!"
else
    error "Issue packaging!"
    exit $res
fi
