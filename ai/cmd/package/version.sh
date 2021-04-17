#!/bin/bash
set +o posix

"${0%/*}"/../../ai.sh docs releaselog $npm_package_version
git add .