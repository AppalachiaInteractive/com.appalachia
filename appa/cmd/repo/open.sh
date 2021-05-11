#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

repo=$(git remote get-url origin)



firefox -new-tab -url "${repo/.git/''}" 