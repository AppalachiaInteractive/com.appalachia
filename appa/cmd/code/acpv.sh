#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -ne 2 ] ; then 
    argserror $'[PARAMS] [commit message] [major/minor/patch/current/existing]'
    exit 1
fi

attempt 'Attempting to add, commit, push, and version...'

if [ "${REPO_HOME}" == "${HOME}/com.appalachia" ] ; then
    error 'Check your directory...'
    exit 1
fi

"${APPA_COMMAND_HOME}/code/acp.sh" "$1"
"${APPA_COMMAND_HOME}/code/version.sh" "$2"

success 'Added, committed, pushed, and versioned!'