#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ "${APPA_DEBUG}" == "1" ] ; then echo "[ARGS] [#: $#] $@"; fi

if  [ $# -ne 2 ] ; then 
    argserror $'[PARAMS] [commit message] [major/minor/patch]'
    exit 2
fi

appa multi locals appa code ship "$@"