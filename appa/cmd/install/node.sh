#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

install_node() {
    local opwd="$PWD"

    cd "$APPA_SETUP"

    if ! msiexec -i "node-v14.16.1-x64.msi"; then
        error "Failed to install node!"
        cd "$opwd"
        exit 1
    fi

    cd "$opwd"
}

install_node "$@"