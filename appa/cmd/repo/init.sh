#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


shopt -s nullglob
shopt -s dotglob 

if [ $# -ne 3 ] ; then
    argserror 'Requires 3 arguments: name private/public "description"'
    exit 3
fi

if [ "$2" != "private" ] && [ "$2" != "public" ] ; then
    argserror 'Argument 2 must be "private" or "public"'
    exit 2
fi

do_repo_init() {
    local repo_path="$1"
    local pubpri="--$2"
    local repo_description="$3"    
    
    gh repo create $repo_path ${pubpri} -d "${repo_description}"
    gh repo clone $repo_path tmp
    mv tmp/* tmp/.* .
    rmdir tmp
    git add README.md
    git commit -m 'Added README.md'
    git add .
    git commit -m "Initializing organization repository for project."
    git push -u origin main

    success "Initialized repo!"

}

do_repo_init "$@"
