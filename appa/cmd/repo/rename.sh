#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -ne 2 ] ; then 
    argserror $'[PARAMS] [old package name] [new package name]'
    exit 2
fi

if  [ "${1}" == "" ] || [ "${2}" == "" ]; then 
    argserror $'[PARAMS] [old package name] [new package name]'
    exit 2
fi

package=$(appa vars package)

if [ "${package}" == "" ] ; then 
    argserror $"Execute from a directory with package.json."
    exit 1
fi

if  [ $# -eq 0 ] || [ $# -gt 2 ] ; then 
    argserror $"[PARAMS] [old package name] [new package name] - Provided [old package name] does not match package.json contents."
    exit 3
fi

attempt "Renaming package [${1}] to [${2}]..."

pattern="s/${1}/${2}/g"
find . -mindepth 1 -maxdepth 3 -type f -name '*' -exec grep -Iq . {} \; -exec sed -i "${pattern}" {} \;

note "Renaming github repository..."
gh api -X PATCH "repos/AppalachiaInteractive/${1}" -f "name=${2}" || exit

git fetch -p
git status
