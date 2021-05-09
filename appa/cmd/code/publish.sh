#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

code_publish() {
    attempt "Attempting to publish..."

    win_home=$(echo "${HOME}/com.appalachia"|sed -e 's_/c/_C:/_g')

    if [ "${REPO_HOME}" == "${win_home}" ] ; then
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
    python -m appapy publish ${bump}
    res=$?



    if [ ${res} -eq 0 ] ; then
        success 'Published successfully!'
    else
        error 'Failed to publish!'
    fi

    exit $?
}

code_publish "$@"