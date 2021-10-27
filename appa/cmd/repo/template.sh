#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

attempt "Setting up repository..."

args="$*"

unity3rd="1 1 3 1 1 1 1 1 1 1 0"
unity1st="1 1 2 1 1 1 1 1 1 1 1"

echo "$1"

if [[ "$1" == "unity3rd" ]] ; then
    args="${unity3rd}"
elif [[ "$1" == "unity1st" ]] ; then
    args="${unity1st}"
fi

python -m appapy templating $args
res=$?
if [ ${res} -eq 0 ] ; then
    #rm -- "$0"
    success "Repository setup complete!"
else
    error "Issue setting up repository!"
    exit ${res}
fi
