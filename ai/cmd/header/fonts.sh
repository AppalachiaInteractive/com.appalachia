readarray -t fonts < "${0%/*}/fonts.txt"

test="ABCDE 01234 !?:@"

for font in "${fonts[@]}"
do 
    clean_font="$(echo $font || sed "s/\n//g")"

    echo "---------------------------------"
    echo "|     $clean_font"
    echo "---------------------------------"
    figlet "$test" -f "$clean_font" --horizontal-layout 'fitted'
done  