#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

attempt "Attempting to publish..."

bump="$1"

original_pwd="$PWD"

echo "${original_pwd}"

note 'Moving to python path directory to activate environment...'

cd "${PYTHONPATH}"
note 'Invoking environment change...'
source appa.sh venv activate

cd "${original_pwd}"
note 'Executing...'
python -m appapy publish $bump
res=$?



if [ $res -eq 0 ] ; then
    success 'Published successfully!'
else
    error 'Failed to publish!'
fi

exit $?