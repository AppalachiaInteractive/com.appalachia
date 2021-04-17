if [ $# -lt 3 ] ; then
    echo 'Provide [header], [subtitle], [subtitle font] -or-'
    echo 'Provide [header], [subtitle], [subtitle font], ["options"] -or-'
    echo 'Provide [header], [subtitle], [subtitle font], ["header options"], ["subtitle options"]'
    exit 3
fi

header=$1; shift;
subtitle=$1; shift;
subtitle_font=$1; shift;

if [ $# -eq 0 ] ; then
    ai.sh print "$header" "Contessa" "$@"
    ai.sh print "$subtitle" "$subtitle_font" "$@"
elif [ $# -eq 1 ] ; then
    ai.sh print "$header" "Contessa" "$1"
    ai.sh print "$subtitle" "$subtitle_font" "$1"
else
    ai.sh print "$header" "Contessa" "$1"; shift
    ai.sh print "$subtitle" "$subtitle_font" "$1"
fi


