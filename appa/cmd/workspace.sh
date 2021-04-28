#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -ne 1 ] ; then 
    argserror $'[PARAMS] [WORKSPACE]'
    exit 1
fi

workspace="${APPA_HOME}/workspaces/${1}.code-workspace"

if [ ! -f "${workspace}" ] ; then
    error $"Workspace [${1}] does not exist."
    argserror $'[PARAMS] [WORKSPACE]'
    exit 2
fi

code "${workspace}"