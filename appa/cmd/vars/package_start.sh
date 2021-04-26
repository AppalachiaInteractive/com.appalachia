#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


dir="${0%/*}"
full=$($dir/package.sh)
end=$($dir/package_end.sh)

echo "${full##*.}"