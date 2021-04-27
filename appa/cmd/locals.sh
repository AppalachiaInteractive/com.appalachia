#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

locals_opwd="$PWD"

repos=($(find . -type d -name .git|sed 's/.git//g'))

for repo in "${repos[@]}" ; do
    echo
    highlight '-------------------------------------'
    highlight "Repository : $repo"
    highlight '-------------------------------------'
    note "Moving into repository."
    cd "$locals_opwd" || exit
    cd "${repo}" || exit
    note "Executing command: [$*]"

    "$@"    
done

cd "$locals_opwd"
