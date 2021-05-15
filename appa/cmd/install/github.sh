#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

install_github() {

    local opwd="$PWD"

    cd "$APPA_SETUP"

    if ! msiexec -i "gh_1.8.1_windows_amd64.msi"; then
        error "Failed to install github CLI!"
        cd "$opwd"
        exit 1
    fi

    cd "$opwd"
}

install_github "$@"