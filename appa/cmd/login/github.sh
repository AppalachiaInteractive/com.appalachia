#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ "${APPA_DEBUG}" == "1" ] ; then echo "[ARGS] [#: $#] $@"; fi

gh auth status

if [ $? -ne 0 ] ; then
    gh auth login
fi
