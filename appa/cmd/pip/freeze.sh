#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

venv_dir="${REPO_HOME}/.venv"
req_file="${REPO_HOME}/requirements.txt"

if [ -d "${venv_dir}" ] ; then
    if [ -f "${req_file}" ] ; then
        echo 'Freezing requirements...'
        pip freeze > "${req_file}"
    fi
fi
