#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


readarray -t fonts < "${0%/*}/fonts.txt"

test="ABCDE 01234 !?:@"

i=0
for font in "${fonts[@]}"
do 
    clean_font="$(echo $font || sed "s/\n//g")"

    note "---------------------------------"
    note "|     $clean_font"
    note "---------------------------------"
    figlet "$test" -f "$clean_font" --horizontal-layout 'fitted'
    i=`expr $i + 1`
    
    if [ $i -eq 10 ] ; then
        i=0
        echo; read -rsn1 -p "${C_WARN}Press q to quit; press any other key to continue . . .${C_RST}" variable; echo

        if [ "$variable" == "q" ] || [ "$variable" == "Q" ] ; then
            exit 0
        fi
    fi
done  