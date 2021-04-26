#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -eq 0 ] || [ $# -gt 2 ] ; then 
    argserror $'[PARAMS] [package] [optional: version]'
    exit 2
fi

if [ $# -eq 1 ] ; then
    npm --registry http://localhost:4873 unpublish "com.appalachia.${1}" --force
else
    npm --registry http://localhost:4873 unpublish "com.appalachia.${1}@${2}"
fi


