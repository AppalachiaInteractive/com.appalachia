#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

arg_key=$1

secrets_require_args get "$#" 1
read_secrets | extract_secret "$arg_key"