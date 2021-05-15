#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

cmd_py() {
    local opwd="${PWD}"
    echo "${opwd}"

    note 'Moving to python path directory to activate environment...'

    cd "${PYTHONPATH}"
    note 'Invoking environment change...'
    source appa.sh venv activate

    cd "${opwd}"
    note 'Executing...'
    python -m appapy "$*"
    res=$?

    if [ ${res} -eq 0 ] ; then
        success 'Success!'
    else
        error 'Failure! :('
    fi

    exit $?
}
