#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

cut -d "=" -f 2 <<< $(npm run env | grep "npm_package_name")