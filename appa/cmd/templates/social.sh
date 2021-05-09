#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

attempt "Attempting to update social icon templates..."

note "Finding main copy..."
extension=".svg"
target_name="icon_social${extension}"
target_file="${HOME}/com.appalachia/appa/templates/.common/media/${target_name}"

note "Searching for instances..."

find -O3 . \
-name "${target_name}" \
-type f \
-path "*${extension}" \
-not -path "${target_file}" \
-not -path "**/design/**" \
-not -path "**/Library/**" \
-not -path "**/node_modules/**" \
-not -path "**/site-packages/**" \
-not -path "**/.env/**" \
-not -path "**/.venv/**" \
-not -path "**/.git/**" \
-not -path "**/.idea/**" \
-not -path "**/.vscode/**" \
-exec sh -c \
'cp "${2}" "${1}"' \
_ "{}" "$target_file" ';'
