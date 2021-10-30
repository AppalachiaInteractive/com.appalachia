#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


if [ $# -gt 2 ] || [ $# -lt 1 ] ; then
    argserror 'Requires 1-2 arguments: [optional:SOURCE] [TARGET]'
    exit 2
fi

if [ $# -eq 1 ] ; then
    source="."
    target="$1"
else
    source="$1"
    target="$2"
fi

bcomp "$source" "$target" &
