#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

arg_key=$1
arg_value=$2

if [ "$#" = "1" ] ; then
    stty -echo ; trap "stty echo" EXIT
    read -p "Value: " value
    echo ; stty echo ; trap - EXIT

    if [ -z "$value" ] ; then
    echo "ERROR: cowardly refusing to set an empty value" >&2
    exit 1
    fi
elif [ "$#" = "2" ] ; then
    value=$arg_value
else
    secrets_require_args "$command" "$#" 2
fi
read_secrets | (
    filter_secret "$arg_key"
    printf "%q %q %q\n" "$(secrets_urlencode "$arg_key")" "$(date '+%s')" "$(secrets_urlencode "$value")"
) | write_secrets

eval $(read_secrets | export_secrets)