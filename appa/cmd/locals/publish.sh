#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ "${APPA_DEBUG}" == "1" ] ; then echo "[ARGS] [#: $#] $@"; fi

if  [ $# -ne 1 ] ; then 
    argserror $'[PARAMS] [major/minor/patch/current/existing]'
    exit 1
fi

appa multi locals appa code publish "$@"

