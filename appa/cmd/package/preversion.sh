#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi

set +o posix

version=$npm_package_version

git fetch -p
git pull --tags

"${0%/*}"/../../appa docs changelog

git add .