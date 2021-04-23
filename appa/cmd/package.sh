#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

if [ $# -eq 0 ] ; then
    echo "${C_ARGSERR}Must specify at least one argument for packaging.${C_RST}"
    exit 1
fi

echo "${C_NOTE}Executing packaging ${C_FUNC}${1}${C_RST}..."

python -m 'appapy' packaging "$@"

res=$?
if [ $res -eq 0 ]
then
    #rm -- "$0"
    echo "${C_SUC}Packaging ${1} completed!${C_RST}"
else
    echo "${C_ERR}Issue packaging!${C_RST}"
    exit $res
fi
