#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if  [ $# -ne 1 ] ; then 
    argserror $'Need to provide [RELATIVE FILE PATH]'
    exit 1
fi

relative_file_path="${1}"

file_exists=1

if [ ! -f "${relative_file_path}" ] ;
then
    file_exists=0
    options=("no" "yes")
    inputChoice "Could not find file at [${relative_file_path}].  Do you want to proceed anyway?" 0 "${options[@]}"; choice=$?
    
    if [ $choice -eq 0 ] ; then
        note 'Cancelling now.'
        exit 2
    fi
fi

options=("no" "yes")
inputChoice "Are you sure you want to delete the history of [${relative_file_path}]:" 0 "${options[@]}"; choice=$?

if [ $choice -eq 0 ] ; then
    note 'Whew!  That was a close one!'
    exit 3
fi

if [ $file_exists -eq 1 ] ;
then
    options=("no" "yes")
    inputChoice "Do you want to back this file up?:" 1 "${options[@]}"; choice=$?

    if [ $choice -eq 1 ] ; then
        note 'Backing up now!'
        filename=$(basename "${relative_file_path}")
        destination="${APPA_HOME}/.backup-files/${filename}"

        if ! cp "${relative_file_path}" "$destination" ;
        then
            error 'Backup failed!  Will not update history.'
            exit 4
        fi    
    fi
fi

java -jar "${APPA_BIN}/bfg.jar" -D "${relative_file_path}" --no-blob-protection

note 'Review the notes above and then run: appa repo expire'

