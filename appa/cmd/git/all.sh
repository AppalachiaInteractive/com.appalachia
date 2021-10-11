#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

repos=($(grep -rl --include=config "/github.com/AppalachiaInteractive"|sed 's/.git\/config//g'))

for repo in "${repos[@]}" ; do
    echo
    highlight '-------------------------------------'
    highlight "Repository : ${repo}"
    highlight '-------------------------------------'
    note "Executing command: [git -C \'${repo}\" $*]"

    git -C "${repo}" "$@"
    
done