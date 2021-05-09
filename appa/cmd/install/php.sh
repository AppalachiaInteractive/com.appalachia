#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

install_php() {
    local opwd="$PWD"

    folder_path="${APPA_HOME}/appa/.setup"

    cd "$folder_path"

    file_path="WebPlatformInstaller_x64_en-US.msi"

    if [ ! -f "/C/Program Files/Microsoft/Web Platform Installer/WebPICMD.exe" ] ; then
        msiexec -i "${file_path}"
    fi

    if ! command -v php &> /dev/null
    then
        WebPICMD "/Install" "PHP74x64"
    fi
    cd "$opwd"
}

install_php "$@"