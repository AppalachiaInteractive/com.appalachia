#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


design="${APPA_DESIGN}/"
web="${APPA_WEB_PUBLIC}/wp-content/uploads/"
mapfile -t result < <(find "${design}" -mindepth 1 -type f -not -path '*/.*' -not -path '*/_*' \( -path '*.png' -or -path '*.svg' \) )

copy_logos "$design" "$web" "${result[@]}"

logos="${design}logos/"
web_logos="${web}logos/"
mapfile -t result < <(find "${logos}" -mindepth 1 -type f -not -path '*/.*' -not -path '*/_*' \( -path '*.ai' -or -path '*.pdf' -or -path '*.png' -or -path '*.svg' \) )

copy_logos "$logos" "$web_logos" "${result[@]}"

output_zip="${logos}logos.zip"

final_zip="$(echo -e "${output_zip}" | sed -e "s|$logos|$web_logos|g")"

if [ -f "$output_zip" ] ; then
    rm "$output_zip"
fi

7z a -r "${output_zip}" "${logos}"

echo copyfile "${output_zip}" "${final_zip}"
copyfile "${output_zip}" "${final_zip}"

git --git-dir "${APPA_DESIGN}/.git" --work-tree "${APPA_DESIGN}" add "${design}"
git --git-dir "${APPA_DESIGN}/.git" --work-tree "${APPA_DESIGN}" commit -m "Updating logos"
git --git-dir "${APPA_DESIGN}/.git" --work-tree "${APPA_DESIGN}" push

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