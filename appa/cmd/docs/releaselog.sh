#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

release_header=$'Released Changes\n'
file_name="RELEASELOG.md"
header='RELEASE'
unheader='STAGED'
font='Sub-Zero'

attempt "Attempting to update release log..."

tag="${npm_package_version}"; 
previous_tag=$(git describe --exclude upm --abbrev=0 --tags)

if [ "${tag}" == "" ] && [ $# -ge 1 ] ; then
    tag="$1"; 
    previous_tag=$(git describe --exclude upm --abbrev=0 --tags "${tag}^")
fi

if [ "${tag}" == "" ] ; then
    tag=$(git describe --exclude upm --abbrev=0 --tags); 
    previous_tag=$(git describe --exclude upm --abbrev=0 --tags "${tag}^")
fi

if [ "${tag}" == "" ] ; then
    tag="Unreleased"; 
    previous_tag="None"
    header=${unheader}
    echo "Tag: [${tag}]  | Previous Tag: [${previous_tag}]"
    
    content=$(git log --pretty='| %H | %as | %an | %s |')
    
elif [ "${previous_tag}" == "" ] ; then
    previous_tag="None"
    echo "Tag: [${tag}]  | Previous Tag: [${previous_tag}]"    
    content=$(git log --pretty='| %H | %as | %an | %s |')
    
else
    echo "Tag: [${tag}]  | Previous Tag: [${previous_tag}]"

    previous_tag_hash=$(git rev-list -n 1 ${previous_tag})
    commit_after_previous=$(git log --reverse --ancestry-path "${previous_tag_hash}..HEAD" | head -n 1 | cut -d \  -f 2)
    content=$(git log --pretty='| %H | %as | %an | %s |' "${commit_after_previous}..HEAD")
fi

note "Starting release log updates..."

table_header=$'| Hash | Date | Author | Changes |\n|------|------|--------|---------|'

if [ "${APPA_DEBUG}" == "1" ] ; then 
    echo '------------------------- "${content}"'
    echo "${content}"
fi

echo "${file_name}"

echo '```' > ${file_name}
echo "`appa print "${header}" "${font}" --horizontal-layout fitted`" >> ${file_name}
echo '```' >> ${file_name}
echo $'\n' >> ${file_name}
echo "## ${release_header}" >> ${file_name}
echo '`'"${tag}"'`' >> ${file_name}
echo "${table_header}" >> ${file_name}
echo "${content}" >> ${file_name}
sed -i '/| 0\./d' ${file_name}

success "Changelog updates completed."
if [ "${APPA_DEBUG}" == "1" ] ; then 
    echo "------------------------- ${file_name} -------------------------"
    cat ${file_name}
    echo "------------------------- ${file_name} -------------------------"
fi
