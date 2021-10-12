#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

repos=($(grep -rl --include=config "/github.com/AppalachiaInteractive"|sed 's/.git\/config//g'))

changedCount=0

for repo in "${repos[@]}" ; do

    log=$(git -C "${repo}" diff --stat)

    if [[ -n "${log}" ]]; then

        subtle '-------------------------------------'
        highlight2 "Repository : ${repo}"
        highlight1 "${log}"
        ((changedCount += 1))

    fi
        
done

echo
subtle '-------------------------------------'
highlight3 "${changedCount} repositories with changes."
subtle '-------------------------------------'
echo