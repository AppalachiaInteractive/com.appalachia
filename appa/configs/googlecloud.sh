#!/bin/bash
name="googlecloud";
shopt -s nullglob; fg=$(tput setf 3); suc=$(tput setf 2); rst=$(tput sgr0);
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${fg}Loading ${name} configuration...${rst}"; fi
set -a
APPA_CONFIG_GOOGLECLOUD='LOADED'
## ------------------------------------

GOOGLE_APPLICATION_CREDENTIALS="${APPA_PRIVATE}/keepers-of-creation-829983f094f1.json"

if [ ! -f "${GOOGLE_APPLICATION_CREDENTIALS}" ]; then
    warn "File \"${GOOGLE_APPLICATION_CREDENTIALS}\" does not exist, and Google Cloud Service accounts will not work."
fi
