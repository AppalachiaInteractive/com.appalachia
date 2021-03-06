#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

venv_dir="${REPO_HOME}/.venv"
req_file="${REPO_HOME}/requirements.txt"

if [ -d "${venv_dir}" ] ; then
    if [ -f "${req_file}" ] ; then
        note "Freezing requirements..."
        pip freeze > "${req_file}"
        success "Froze requirements!"
    fi
fi
