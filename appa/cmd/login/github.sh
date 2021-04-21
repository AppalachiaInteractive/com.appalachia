#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

if [ "$APPA_DEBUG" == "1" ] || [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi
if [ "$APPA_DEBUG" == "1" ] ; then echo "[ARGS] [#: $#] $@"; fi

gh auth status

if [ $? -ne 0 ] ; then
    gh auth login
fi
