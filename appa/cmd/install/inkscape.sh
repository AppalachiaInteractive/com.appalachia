#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

install_inkscape() {
    local opwd="$PWD"

    cd "$APPA_SETUP"

    if ! msiexec -i "inkscape-1.0.2-2-x64.exe"; then
        error "Failed to install inkscape!"
        cd "$opwd"
        exit 1
    fi

    cd "$opwd"
}

install_inkscape "$@"