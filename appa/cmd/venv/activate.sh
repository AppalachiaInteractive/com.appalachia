#!/bin/bash
. "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


venv_dir="${REPO_HOME}/.venv"
activate_file="${venv_dir}/Scripts/activate"
req_file="${REPO_HOME}/requirements.txt"

if [ -d "${venv_dir}" ] ; then

    attempt "Attempting to activate virtual environment..."
    #note "$PATH"

    #note "Activating virtual environment..."        
    . "${activate_file}"

    if [ -f "${req_file}" ] ; then
        #note "Installing requirements..."
        pip install -r "${req_file}" 1> /dev/null
    fi

    success "Virtual environment active!"
fi
