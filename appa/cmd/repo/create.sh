#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"


shopt -s nullglob
shopt -s dotglob 

if [ $# -ne 3 ] ; then
    echo 'Requires 3 arguments: name private/public "description"'
    exit 3
fi

if [ "$2" != "private" ] && [ "$2" != "public" ] ; then
    echo 'Argument 2 must be "private" or "public"'
    exit 2
fi

path="$1"
pubpri="--$2"
description="$3"

gh repo create $path $pubpri -d "$description"
gh repo clone $path tmp
mv tmp/* tmp/.* .
rmdir tmp
git add README.md
git commit -m 'Added README.md'
git add .
git commit -m "Initializing organization repository for project."
git push -u origin main
