#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

if [ $# -lt 1 ] ; then
    argserror 'Need to provide a test string.  Just use `showoff` or `fonts` if you want to see the options.'
    exit 1
fi

readarray -t fonts < "${0%/*}/fonts.txt"

message=$1
shift

i=0
for font in "${fonts[@]}"
do 
    clean_font="$(echo "${font}" || sed "s/\n//g")"

    note '----------------------------------------------------------------'
    note '------------------------'"${clean_font}"
    note '----------------------------------------------------------------'
    figlet "${message}" -f "${clean_font}" "$@"
    i=$((i+1))
    
    if [ $i -eq 10 ] ; then
        i=0
        echo; read -rsn1 -p "Press q to quit; press any other key to continue . . ." variable; echo;

        if [ "${variable}" == "q" ] || [ "${variable}" == "Q" ] ; then
            exit 0
        fi
    fi
done