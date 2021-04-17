release_header="# Released Changes\n\n"
file_name="RELEASELOG.md"
header='RELEASE'
font='Sub-Zero'

echo "Starting release log updates..."

if [ $# -lt 1 ] ; then
    tag=$(git describe --abbrev=0)  
    previous_tag=$(git describe --abbrev=0 $tag^)
else
    tag=$npm_package_version
    previous_tag=$(git describe --abbrev=0)
fi

previous_tag_hash=$(git rev-list -n 1 $previous_tag)
commit_after_previous=$(git log --reverse --ancestry-path $previous_tag_hash..main | head -n 1 | cut -d \  -f 2)
content=$(git log --pretty='| %h | %as | %an | %s |' $commit_after_previous..HEAD)

table_header="| Hash | Date | Author | Changes |\n|------|------|--------|---------|"
table_header_a=$'| Hash | Date | Author | Changes |\n|------|------|--------|---------|'

#echo '------------------------- "$content"'
#echo "$content"

echo '```' > $file_name
echo "`ai.sh print "$header" "$font" --horizontal-layout fitted`" >> $file_name
echo '```' >> $file_name
echo $'\n' >> $file_name
echo "# $tag" >> $file_name
echo "$table_header_a" >> $file_name
echo "$content" >> $file_name
sed -i '/| 0\./d' $file_name

echo "Changelog updates completed."
echo "------------------------- $file_name -------------------------"
cat $file_name
echo "------------------------- $file_name -------------------------"
