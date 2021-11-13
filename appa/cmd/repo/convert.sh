#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -ne 1 ] ; then 
    argserror $'Need to provide [FILE EXTENSION]'
    exit 1
fi

search_path="${1}"

options=("no" "yes")
inputChoice "Are you sure you want to delete the history of [${search_path}]:" 0 "${options[@]}"; choice=$?

if [ $choice -eq 0 ] ; then
    note 'Whew!  That was a close one!'
    exit 3
fi

java -jar "${APPA_BIN}/bfg.jar" --convert-to-git-lfs "*.{${search_path}}" --no-blob-protection "${REPO_HOME}/.git"

note '------------------------------------------------------'
note 'Review the notes above and then run: appa repo expire'

