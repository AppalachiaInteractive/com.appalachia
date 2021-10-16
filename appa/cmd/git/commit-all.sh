#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

repos=($(grep -rl --include=config "/github.com/AppalachiaInteractive"|sed 's/.git\/config//g'))

changedCount=0

function print_repo () {    
    subtle '-------------------------------------'
    highlight2 "Repository : ${1}"
    subtle '-------------------------------------'
}


for repo in "${repos[@]}" ; do

    log=$(git -C "${repo}" status -s)

    if [[ -n "${log}" ]]; then

        echo
        print_repo "${repo}"

        git -C "${repo}" diff --stat
        ((changedCount += 1))

        subtle '-------------------------------------'

        read -rep " >  Enter your commit message? " -i "" answer

        git -C "${repo}" add . && git -C "${repo}" commit -m "${answer}" && git -C "${repo}" push -q

        res=$?
        if [ ${res} -ne 0 ] ; then 
            exit ${res}
        fi

        subtle '-------------------------------------'
        echo "Pushed repositoy successfully."
    fi        
done

echo
subtle '-------------------------------------'
highlight3 "${changedCount} repositories with changes."
subtle '-------------------------------------'
echo