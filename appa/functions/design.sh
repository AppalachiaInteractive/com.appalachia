#!/bin/bash

copy_logos() {
    local current_logos="$1"
    shift
    local web_logos="$1"
    shift
    local result=("$@")

    local length=${#result[@]}
    local item
    local newpath
    local filename

    clearPids

    for ((index=0; index < length; index++)); do

        progressStep=$((index+1))
        progressLength=$((length+1))

        item="${result[index]}"

        if [ "${item}" == "" ] ;
        then
            progressBar "Copy logo:" ${progressStep} ${progressLength}
            continue
        fi    
        
        newpath="${item//$current_logos/$web_logos}"
        filename=$(basename "$newpath")

        copynewerfile "${item}" "${newpath}"      
        if [ "${item: -4}" == ".svg" ] ; then
            if [ "${item}" -nt "${newpath}" ] ; then 
                svgo -i "${newpath}" --config "${APPA_SVGO_CONFIG}" &
                addPid $! "${newpath/web_logos/ /}"
            fi            
        fi

        progressBar "${filename}" ${progressStep} ${progressLength}

    done

    waitPids 3

    echo
    echo
    note "Finished copying $length logos!"
}