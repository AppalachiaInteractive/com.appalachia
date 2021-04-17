#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi

gh auth status

if [ $? -ne 0 ] ; then
    gh auth login
fi
