#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

web_logos="${APPA_WEB_PUBLIC}/wp-content/uploads/"

mapfile -t result < <(find "${web_logos}" -mindepth 1 -type f -path '*.svg')

length=${#result[@]}


clearPids

for ((index=0; index < length; index++)); do
    item="${result[index]}"    

    if [ "${item: -4}" == ".svg" ] ; then

        svgo -i "${item}" --config "${APPA_SVGO_CONFIG}" &
        addPid $! "${item}"
    fi        
done

waitPids 3

echo
echo
note "Finished optimizing $length SVGs!"

git_command="git --git-dir ${APPA_WEB_PUBLIC}/.git --work-tree ${APPA_WEB_PUBLIC}"
if ! $git_command add "${APPA_WEB_PUBLIC}" ; then
    exit 1
fi
if ! $git_command commit -m "Optimizing SVGs."  ; then
    exit 1
fi
if ! $git_command push ; then
    exit 1
fi

success 'Optimized SVGs and pushed changes!'