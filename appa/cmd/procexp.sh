#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

target="${APPA_SCRIPT_HOME}/.bin/procexp.exe"
echo "${target}"
"${target}" "$@" &


