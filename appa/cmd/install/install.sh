#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

log_error(){
    error "Issue installing.  Exiting now.  Try again after fixing the issues.  Unless YOU are the issue...no it's probably the computer."
    exit 1
}

echo "> appa install python"
if ! appa install python; then
    log_error
fi

echo "> appa install node"
if ! appa install node; then
    log_error
fi

echo "> appa install php"
if ! appa install php; then
    log_error
fi

echo "> appa install github"
if ! appa install github; then
    log_error
fi

echo "> appa install inkscape"
if ! appa install inkscape; then
    log_error
fi
echo "> appa install wordpress"
if ! appa install wordpress; then
    log_error
fi

echo "> appa install filezilla"
if ! appa install filezilla; then
    log_error
fi

echo "> appa install imagemagick"
if ! appa install imagemagick; then
    log_error
fi

success "Installation complete!"