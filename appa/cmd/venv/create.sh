#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

venv_dir="${REPO_HOME}/.venv"

python -m venv "${venv_dir}"

appa venv activate
