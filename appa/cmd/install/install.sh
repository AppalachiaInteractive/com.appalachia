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
appa install node
if ! appa install python; then
    log_error
fi

echo "> appa install php"
appa install php
if ! appa install python; then
    log_error
fi

echo "> appa install github"
appa install github
if ! appa install python; then
    log_error
fi

echo "> appa install inkscape"
appa install inkscape
if ! appa install python; then
    log_error
fi
echo "> appa install wordpress"
appa install wordpress
if ! appa install python; then
    log_error
fi

echo "> appa install filezilla"
appa install filezilla
if ! appa install python; then
    log_error
fi

echo "> appa install imagemagick"
appa install imagemagick
if ! appa install python; then
    log_error
fi

success "Installation complete!"