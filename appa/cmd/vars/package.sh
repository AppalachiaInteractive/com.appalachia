#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi



package="$REPO_HOME"/package.json

if [ -f "$package" ] ; then

    package_name=$(cat package.json \
    | grep \"name\" \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g' \
    | tr -d '[[:space:]]')

    echo $package_name

fi
#    package = (absolute.replace(home, '')
#        .replace('Assets','').replace('internal','').replace('experimental','')
#        .replace('\\\\','.').replace('\\\\','.').replace('\\','.')
#        .replace('/','.').replace('..','.').replace('..','.').replace('..','.')
#        .strip('.'))
