readarray -t fonts < "${0%/*}/fonts.txt"

test="ABCDE 01234 !?:@"

i=0
for font in "${fonts[@]}"
do 
    clean_font="$(echo $font || sed "s/\n//g")"

    echo "---------------------------------"
    echo "|     $clean_font"
    echo "---------------------------------"
    figlet "$test" -f "$clean_font" --horizontal-layout 'fitted'
    i=`expr $i + 1`
    
    if [ $i -eq 10 ] ; then
        i=0
        echo; read -rsn1 -p "Press q to quit; press any other key to continue . . ." variable; echo

        if [ "$variable" == "q" ] || [ "$variable" == "Q" ]; then
            exit 0
        fi
    fi
done  