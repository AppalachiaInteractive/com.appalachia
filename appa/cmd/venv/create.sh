#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

note "Creating virtual environment..."
venv_dir="${REPO_HOME}/.venv"

python -m venv "${venv_dir}"

source appa.sh venv activate

success "Created virtual environment!"