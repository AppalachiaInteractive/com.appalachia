#!/bin/bash
name="npm";
shopt -s nullglob; fg=$(tput setf 3); suc=$(tput setf 2); rst=$(tput sgr0);
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${fg}Loading ${name} configuration...${rst}"; fi
set -a
APPA_CONFIG_NPM='LOADED'
## ------------------------------------

NPM_USER="chris"
NPM_EMAIL="chris@appalachiainteractive.com"
NPM_REGISTRY="http://35.211.123.13:4873/"


## ------------------------------------
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${suc}Completed loading ${name} configuration.${rst}"; fi
set +a