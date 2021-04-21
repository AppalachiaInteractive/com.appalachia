#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

set +o posix

version=$npm_package_version

git fetch -p
git pull --tags

"${0%/*}"/../../appa docs changelog

git add .