#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

set +o posix

"${0%/*}"/../../appa docs releaselog $npm_package_version
git add .