#!/bin/bash

preexec() {    
    # check if input is a command that could trigger direnv to activate an environment
    relevant_commands=$(echo ${1} | grep 'cd\|direnv\|.envrc')

    # set some environment variables so that we know in the precmd to update the path.
    if [ "${relevant_commands}" == "" ] ; then
        export DIRENV_FIX_PATH=0
        export DIRENV_OLD_PATH=''
    else
        export DIRENV_FIX_PATH=1
        export DIRENV_OLD_PATH="$PATH"
        filepath="${APPA_SCRIPT_HOME}/.path"
        echo "export PATH='$PATH'" > "${filepath}"
    fi
}