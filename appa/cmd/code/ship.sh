#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

if  [ $# -ne 2 ] ; then 
    echo $'[PARAMS] [commit message] [major/minor/patch]'
    exit 2
fi

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

appa repo publish "$2"