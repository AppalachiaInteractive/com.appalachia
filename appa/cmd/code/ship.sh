#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -ne 2 ] ; then 
    argserror $'[PARAMS] [commit message] [major/minor/patch]'
    exit 2
fi

attempt 'Attempting to ship...'

git add .
result=$?

if [ $result -ne 0 ] ; then
    echo $result
    exit $result
fi

git commit -m "$1"
result=$?

if [ $result -gt 1 ] ; then
    echo $result
    exit $result
fi

git push
result=$?

if [ $result -ne 0 ] ; then
    echo $result
    exit $result
fi

appa code publish "$2"

success 'Shipped!'