#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


templates_legal(){
    attempt "Attempting to update legal documents..."

    local opwd="${PWD}"
    legal_home="${HOME}/com.appalachia/org/legal"
    legal_file="${legal_home}/project-template/LEGAL.md"

    note "Refreshing legal repository"
    cd "${legal_home}"
    git fetch -p && git pull
    cd "${lowpd}"


    note "Finding main copy..."

    note "Searching for legal documents..."

    find -O3 "${opwd}" \
    -name "LEGAL.md" \
    -type f \
    -path "*.md" \
    -not -path "${legal_file}" \
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
    _ "{}" "$legal_file" ';'
}

templates_legal "$@"