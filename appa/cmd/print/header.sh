#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


if [ $# -lt 3 ] ; then
    argserror 'Provide [header], [subtitle], [subtitle font] -or-'
    argserror 'Provide [header], [subtitle], [subtitle font], ["options"] -or-'
    argserror 'Provide [header], [subtitle], [subtitle font], ["header options"], ["subtitle options"]'
    exit 3
fi

font="Contessa"
header=$1; shift;
subtitle=$1; shift;
subtitle_font=$1; shift;

if [ $# -eq 0 ] ; then
    appa print "${header}" "${font}" "$@"
    appa print "${subtitle}" "${subtitle_font}" "$@"
elif [ $# -eq 1 ] ; then
    appa print "${header}" "${font}" "$1"
    appa print "${subtitle}" "${subtitle_font}" "$1"
else
    appa print "${header}" "${font}" "$1"; shift
    appa print "${subtitle}" "${subtitle_font}" "$1"
fi


