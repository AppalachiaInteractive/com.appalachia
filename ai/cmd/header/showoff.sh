readarray -t fonts < "${0%/*}/fonts.txt"

for font in "${fonts[@]}"
do 
    clean_font="$(echo $font || sed "s/\n//g")"

    figlet "$clean_font" -f "$clean_font" --horizontal-layout 'fitted'
done  