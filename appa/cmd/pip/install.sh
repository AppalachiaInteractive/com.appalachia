#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

attempt 'Attempting to install...'

venv_dir="${REPO_HOME}/.venv"
req_file="${REPO_HOME}/requirements.txt"

if [ -d "${venv_dir}" ] ; then
    if [ -f "${req_file}" ] ; then
        note 'Installing requirements...'
        pip install -r "${req_file}"        
    fi
    
    pip install "${1}"
    pip freeze > "${req_file}"
fi

success 'Installed!'