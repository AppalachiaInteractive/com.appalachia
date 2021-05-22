#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


current_logos="${APPA_DESIGN}/"
web_logos="${APPA_WEB_PUBLIC}/wp-content/uploads/"

mapfile -t result < <(find "${current_logos}" -mindepth 1 -type f -not -path '*/.*' -not -path '*/_*' \( -path '*.png' -or -path '*.svg' \) )

length=${#result[@]}

clearPids

for ((index=0; index < length; index++)); do

    progressStep=$((index+1))
    progressLength=$((length+1))

    item="${result[index]}"

    if [ "${item}" == "" ] ;
    then
        progressBar "Copy logo:" ${progressStep} ${progressLength}
        continue
    fi    
    
    newpath="${item//$current_logos/$web_logos}"
    filename=$(basename "$newpath")

    copyfile "${item}" "${newpath}"    

    if [ "${item: -4}" == ".svg" ] ; then

        svgo -i "${newpath}" --config "${APPA_SVGO_CONFIG}" &
        addPid $! "${newpath}"
    fi

    progressBar "${filename}" ${progressStep} ${progressLength}

done

waitPids 3

echo
echo
note "Finished copying $length logos!"

git --git-dir ${APPA_DESIGN}/.git --work-tree ${APPA_DESIGN} add "${current_logos}"
git --git-dir ${APPA_DESIGN}/.git --work-tree ${APPA_DESIGN} commit -m "Updating logos"
git --git-dir ${APPA_DESIGN}/.git --work-tree ${APPA_DESIGN} push

git_command="git --git-dir ${APPA_WEB_PUBLIC}/.git --work-tree ${APPA_WEB_PUBLIC}"
if ! $git_command add "${APPA_WEB_PUBLIC}" ; then
    exit 1
fi
if ! $git_command commit -m "Updating logos"  ; then
    exit 1
fi
if ! $git_command push ; then
    exit 1
fi

success 'Updated logos and pushed changes!'