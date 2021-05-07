#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

original_pwd="${PWD}"
echo "${original_pwd}"

note 'Moving to python path directory to activate environment...'

cd "${PYTHONPATH}"
note 'Invoking environment change...'
source appa.sh venv activate

cd "${original_pwd}"
note 'Executing...'
python -m appapy "$*"
res=$?

if [ ${res} -eq 0 ] ; then
    success 'Success!'
else
    error 'Failure! :('
fi

exit $?