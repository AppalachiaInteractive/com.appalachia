#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ $# -ne 1 ]; then
    argserror $'[PARAMS] [major/minor/patch/current/existing]'
    exit 1
fi

code_version() {
    attempt "Attempting to version..."

    win_home=$(echo "${HOME}/com.appalachia" | sed -e 's_/c/_C:/_g')

    if [ "${REPO_HOME}" == "${win_home}" ]; then
        error 'Check your directory...'
        exit 1
    fi

    bump="$1"

    local opwd="${PWD}"
    echo "${opwd}"

    note 'Moving to python path directory to activate environment...'

    cd "${PYTHONPATH}"
    note 'Invoking environment change...'
    source appa.sh venv activate

    cd "${opwd}"
    note 'Executing...'
    python -m appapy version ${bump}
    res=$?

    if [ ${res} -eq 0 ]; then
        success 'Versioned successfully!'
    else
        error 'Failed to version!'
    fi

    exit $res
}

code_version "$@"
