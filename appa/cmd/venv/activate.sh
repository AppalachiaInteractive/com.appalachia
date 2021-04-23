#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

venv_dir="${REPO_HOME}/.venv"
req_file="${REPO_HOME}/requirements.txt"

if [ -d "${venv_dir}" ] ; then
    echo 'Activating virtual environment...'
    "${venv_dir}/Scripts/activate"

    if [ -f "${req_file}" ] ; then
        echo 'Installing requirements...'
        pip install -r "${req_file}"
    fi
fi
