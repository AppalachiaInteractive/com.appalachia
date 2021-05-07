#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

attempt "Setting up repository..."

python -m appapy templating
res=$?
if [ ${res} -eq 0 ] ; then
    #rm -- "$0"
    success "Repository setup complete!"
else
    error "Issue setting up repository!"
    exit ${res}
fi
