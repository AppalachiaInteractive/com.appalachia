#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

target="${APPA_SCRIPT_HOME}/.bin/grepWin-2.0.7_portable.exe"
echo "$target"
"$target" "$@" &


