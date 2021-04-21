#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"



changelog_header="# Change Log\n\n"
file_name="CHANGELOG.md"
header='Changes'
font='3D-ASCII'

echo "Starting changelog updates..."

content=$(git log --pretty='| %h | %as | %an | %s |')
table_header="| Hash | Date | Author | Changes |\n|------|------|--------|---------|"
table_header_a=$'| Hash | Date | Author | Changes |\n|------|------|--------|---------|'

if [ "$APPA_DEBUG" == "1" ] ; then 
    echo '------------------------- "$content"'
    echo "$content"
fi

readarray tag_commits < <( git log --tags --no-walk --pretty='| %h' | sed -e 's/(//g' -e 's/)//g' -e 's/tag://g' -e 's/HEAD//g' -e 's/master//g' -e 's/main//g' -e 's/,//g' -e 's/->//g' -e 's/origin//g' -e 's|/||g' -e 's/  / /g' -e 's/  / /g' -e 's/  / /g' -e 's/\t//g' -e 's/ v/ /g' )
readarray tag_displays < <( git log --tags --no-walk --pretty='%d'   | sed -e 's/(//g' -e 's/)//g' -e 's/tag://g' -e 's/HEAD//g' -e 's/master//g' -e 's/main//g' -e 's/,//g' -e 's/->//g' -e 's/origin//g' -e 's|/||g' -e 's/  / /g' -e 's/  / /g' -e 's/  / /g' -e 's/\t//g' -e 's/ v/ /g' )

if [ "$APPA_DEBUG" == "1" ] ; then 
    printf '%s\n' "${tag_commits[@]}"
    printf '%s\n' "${tag_displays[@]}"
fi

for i in "${!tag_commits[@]}"; do 
    
    tag_commit=`echo "${tag_commits[$i]}" | xargs`
    tag_display=`echo "${tag_displays[$i]}" | xargs`

    if [ "$APPA_DEBUG" == "1" ] ; then 
        echo "$tag_commit"
        echo "$tag_display"
    fi

    replace='\n\n ## Tag: v'"$tag_display"'\n'"$table_header\n$tag_commit"
    if [ "$APPA_DEBUG" == "1" ] ; then 
        echo "Replacement: [$replace]"
    fi

    content=$(echo "$content" | sed "s/$tag_commit/$replace/g")

done

echo '```' > $file_name
echo "`appa print \""$header"\" \""$font"\" --horizontal-layout fitted | head -n -2 `" >> $file_name
echo '```' >> $file_name

echo "## Unreleased" >> $file_name
echo "$table_header_a" >> $file_name
echo "$content"  >> $file_name

sed -i '/| 0\./d' $file_name

echo "Changelog updates completed."

if [ "$APPA_DEBUG" == "1" ] ; then 
    echo "------------------------- $file_name -------------------------"
    cat $file_name
    echo "------------------------- $file_name -------------------------"
fi