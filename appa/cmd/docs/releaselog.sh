#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi



release_header="# Released Changes\n\n"
file_name="RELEASELOG.md"
header='RELEASE'
unheader='STAGED'
font='Sub-Zero'

echo "Starting release log updates..."

if [ $# -lt 1 ] ; then
    tag=$(git describe --abbrev=0)  
    previous_tag=$(git describe --abbrev=0 $tag^)
else
    tag=$npm_package_version
    previous_tag=$(git describe --abbrev=0)
fi

if [ "$tag" == "" ] ; then
    tag="Unreleased"; previous_tag="None"
    header=$unheader
    echo "Tag: [$tag]  | Previous Tag: [$previous_tag]"
    
    content=$(git log --pretty='| %h | %as | %an | %s |')
else
    echo "Tag: [$tag]  | Previous Tag: [$previous_tag]"

    previous_tag_hash=$(git rev-list -n 1 $previous_tag)
    commit_after_previous=$(git log --reverse --ancestry-path $previous_tag_hash..main | head -n 1 | cut -d \  -f 2)
    content=$(git log --pretty='| %h | %as | %an | %s |' $commit_after_previous..HEAD)
fi

echo "Starting release log updates..."

table_header="| Hash | Date | Author | Changes |\n|------|------|--------|---------|"
table_header_a=$'| Hash | Date | Author | Changes |\n|------|------|--------|---------|'

if [ "$APPA_DEBUG" == "1" ] ; then 
    echo '------------------------- "$content"' fi
    echo "$content" fi
fi

echo '```' > $file_name
echo "`appa print "$header" "$font" --horizontal-layout fitted`" >> $file_name
echo '```' >> $file_name
echo $'\n' >> $file_name
echo "# $tag" >> $file_name
echo "$table_header_a" >> $file_name
echo "$content" >> $file_name
sed -i '/| 0\./d' $file_name

echo "Changelog updates completed."
if [ "$APPA_DEBUG" == "1" ] ; then 
    echo "------------------------- $file_name -------------------------"
    cat $file_name
    echo "------------------------- $file_name -------------------------"
fi
