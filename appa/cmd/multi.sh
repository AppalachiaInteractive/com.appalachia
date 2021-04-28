#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

changed_opwd="$PWD"

type=$1
shift

if [ "$type" == "all" ] ; then
    mapfile -t directories < <(find "${APPA_HOME}" -type d -name .git|sed 's/.git//g')
elif [ "$type" == "locals" ] ; then
    mapfile -t directories < <(find . -type d -name .git|sed 's/.git//g')
elif [ "$type" == "changed" ] ; then
    mapfile -t directories < <(find . -type d -name .git|sed 's/.git//g')
elif [ "$type" == "find" ] ; then
    pattern=$1
    shift
    mapfile -t directories < <(find . -type d -name "$pattern"|sed 's/.git//g')
else
    argserror "Need to provide [TYPE (locals, changed, all)] and [COMMAND]."
    exit 2
fi

for directory in "${directories[@]}" ; do
    echo     
    highlight '-------------------------------------'
    note "Moving into directory [$directory]..."
    cd "$changed_opwd" || exit
    cd "${directory}" || exit

    header="Directory : $directory"

    if [ "$type" == "changed" ] ;
    then
        count=$(git status --porcelain=v1 2>/dev/null | wc -l)
        if [ "${count}" == "0" ] ; then
            note "Skipping - no changes."
            continue
        fi
        header="Directory : $directory - [${count} changes]"
    fi

    highlight '-------------------------------------'
    highlight "${header}"
    highlight '-------------------------------------'
    note "Executing command: [$*]"

    "$@"    
done

cd "$changed_opwd"
