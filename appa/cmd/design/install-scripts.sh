#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


illustrator_destination='/c/Program Files/Adobe/Adobe Illustrator 2021/Presets/en_US/Scripts/'
illustrator_script_home="${APPA_DESIGN}/scripts/illustrator"

mapfile -t array < <(find "$illustrator_script_home" -type f -name "*.jsx" -not -path "*/.*")

file_count=${#array[@]}

attempt "Attempting to copy ${file_count} scripts!"

for item in "${array[@]}"; do
    filename=$(basename "$item")
    target="${illustrator_destination}${filename}"

    if ! cp "$item" "$target";
    then
        error "Failed to copy scripts!  Error code ${?}"
        exit 0
    fi
done

success "Copied ${file_count} scripts!"