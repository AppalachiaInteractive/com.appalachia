#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi



dir="${0%/*}"
full=$($dir/package.sh)
echo "${full##*.}"