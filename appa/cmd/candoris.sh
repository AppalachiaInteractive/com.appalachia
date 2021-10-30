#!/usr/bin/env bash

DEBUG_LOG=1
DRY_RUN=1
KEYWORD="schema"

if [ $# -ne 1 ]; then
    read -rep "Enter the client name or acronym: " -i "" CLIENT_NAME
    
    if [[ "${CLIENT_NAME}" == "" ]]; then
        echo "Must provide a client name for token replacement!"
        exit 1
    fi   
else
    CLIENT_NAME="$1";
fi

CLIENT_NAME=$(echo -e "${CLIENT_NAME}" | tr '[:lower:]' '[:upper:]')
CLIENT_NAME=$(echo -e "${CLIENT_NAME}" |  sed -e 's/^[[:space:]]*//' | sed -e 's/[[:space:]]*$//')

if [ $DRY_RUN -eq 1 ] ; then
    echo "Execute in dry run mode."
fi


SCRIPT_PATH="$0"
SHELL_DIR=$(dirname "${SCRIPT_PATH}")
SCRIPTS_DIR="${SHELL_DIR}/.."
ROOT="${SCRIPTS_DIR}/.."

if [ $DEBUG_LOG -gt 0 ] ; then
    echo "SCRIPT_PATH=${SCRIPT_PATH}"
    echo "SHELL_DIR=${SHELL_DIR}"
    echo "SCRIPTS_DIR=${SCRIPTS_DIR}"
    echo "ROOT=${ROOT}"
    echo "CLIENT_NAME=${CLIENT_NAME}"
fi

mapfile -t FOUND_PATHS < <(find "${ROOT}" \( -name "*${KEYWORD}*.xml" -o -name "*${KEYWORD}*.asset" \))

for FOUND_PATH in "${FOUND_PATHS[@]}"; do

    TARGET_PATH=$(echo -e "${FOUND_PATH}" | sed -e "s/${KEYWORD}/${CLIENT_NAME}/g");

    echo "Moving [${FOUND_PATH}] to [${TARGET_PATH}]";

    if [ $DRY_RUN -eq 0 ] ; then   
        mv "${FOUND_PATH}" "${TARGET_PATH}"
    fi
done
