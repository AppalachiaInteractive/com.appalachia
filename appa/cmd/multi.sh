#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

local opwd="${PWD}"

type=$1
shift

if [ "${type}" == "all" ] ; then
    mapfile -t directories < <(find "${APPA_HOME}" -type d -name .git|sed 's/.git//g')
elif [ "${type}" == "locals" ] ; then
    mapfile -t directories < <(find . -type d -name .git|sed 's/.git//g')
elif [ "${type}" == "changed" ] ; then
    mapfile -t directories < <(find . -type d -name .git|sed 's/.git//g')
elif [ "${type}" == "find" ] ; then
    pattern=$1
    shift
    mapfile -t directories < <(find . -type d -name "${pattern}"|sed 's/.git//g')
else
    argserror "Need to provide [TYPE (locals, changed, all)] and [COMMAND]."
    exit 2
fi

function executeDirectory () {
    echo     
    highlight '-------------------------------------'
    note "Moving into directory [${directory}]..."
    cd "${opwd}" || exit
    cd "${directory}" || exit

    header="Directory : ${directory}"

    if [ "${type}" == "changed" ] ;
    then
        count=$(git status --porcelain=v1 2>/dev/null | wc -l)
        if [ "${count}" == "0" ] ; then
            note "Skipping - no changes."
            return
        fi
        header="Directory : ${directory} - [${count} changes]"
    fi

    highlight '-------------------------------------'
    highlight "${header}"
    highlight '-------------------------------------'
    note "Executing command: [$*]"

    "$@"

    res=$?
    if [ ${res} -ne 0 ] ; then
        note "Failed.  Will attempt to process again."
        failed_directories+=("${directory}")   
        ((failure_count += 1))       
    fi

    ((iteration_count++))    
    echo
    note "Completing ${iteration_count} of ${directory_count}"
}

failed_directories=()
failure_count=0
iteration_count=0
directory_count=${#directories[@]}


for directory in "${directories[@]}" ; do
    executeDirectory "$@" 
done

failed_directories2=("${failed_directories[@]}")

if (( failure_count > 0 )); then
    highlight '-------------------------------------'
    highlight "Need to process ${failure_count} failures again."
    highlight '-------------------------------------'
    
    for directory in "${failed_directories2[@]}" ; do
        executeDirectory "$@" 
    done
fi

cd "${opwd}"
