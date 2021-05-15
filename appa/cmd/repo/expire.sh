#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

git reflog expire --expire=now --all 
git gc --prune=now --aggressive