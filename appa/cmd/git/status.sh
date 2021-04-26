#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


repos=(`find "${APPA_HOME}" -type d -name .git|sed 's/.git//g'`)

for repo in ${repos[@]} ; do
    echo $repo
    git -C "$repo" status
done