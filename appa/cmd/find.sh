#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

echo 'find . -maxdepth 1 -type d -not -name "Unity"'
echo 'find . -maxdepth 1 -type d -name "Unity"'