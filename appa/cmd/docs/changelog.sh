#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

file_name="CHANGELOG.md"
header='Changes'
font='3D-ASCII'

attempt "Starting changelog updates..."

table_header=$'| Hash | Date | Author | Changes |\n|------|------|--------|---------|'

content=$(git log --pretty='| %H | %as | %an | %s |')

debug '------------------------- "${content}"'
debug "${content}"

readarray tag_commits < <(git log --exclude="*upm*" --tags --no-walk --pretty='| %h'|sed -e 's/v//g')
readarray tag_displays < <(git log --exclude="*upm*" --tags --no-walk --pretty='%d'|sed -e 's/ (//g' -e 's/HEAD -> //g' -e 's/main, //g' -e 's/master, //g' -e 's/tag: v//g' -e 's/)//g')

if [ "${APPA_DEBUG}" == "1" ] ; then 
    printf '%s\n' "${tag_commits[@]}"
    printf '%s\n' "${tag_displays[@]}"
fi

for i in "${!tag_commits[@]}"; do 
    CLEANED=${COMMAND//[$'\t\r\n']} && CLEANED=${CLEANED%%*( )}

    tag_commit="${tag_commits[$i]//[$'\t\r\n']}" && tag_commit="${tag_commit%%*( )}" && tag_commit="${tag_commit##*( )}"
    tag_display="${tag_displays[$i]//[$'\t\r\n']}" && tag_display="${tag_display%%*( )}" && tag_display="${tag_display##*( )}"

    debug "${tag_commit}"
    debug "${tag_display}"    

    replace=$'\n\n ## Tag: '"\`v${tag_display}\`"$'\n'"${table_header}"$'\n'"${tag_commit}"
    
    debug "Replacement: [${replace}]"    

    #content=$(echo "${content}" | sed "s/${tag_commit}/${replace}/g")
    content="${content/${tag_commit}/${replace}}"

done

file_header=""

echo '```' > ${file_name}
appa print "${header}" "${font}" --horizontal-layout fitted | head -n -2 >> ${file_name}
echo '```' >> ${file_name}
echo "${file_header}" >> ${file_name}
echo "## Releasing" >> ${file_name}
echo "${table_header}" >> ${file_name}
echo "${content}" >> ${file_name}

sed -i '/| 0\./d' ${file_name}

success "Changelog updates completed."

debug "------------------------  ${file_name} -------------------------"
debug_cat ${file_name}
debug "------------------------- ${file_name} -------------------------"
