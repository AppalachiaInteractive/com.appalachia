#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi

set +o posix

"${0%/*}"/../../appa docs releaselog $npm_package_version
git add .