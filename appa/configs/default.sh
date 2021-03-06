#!/bin/bash
name="default";
shopt -s nullglob; fg=$(tput setf 3); suc=$(tput setf 2); rst=$(tput sgr0);
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${fg}Loading ${name} configuration...${rst}"; fi
set -a
APPA_CONFIG_DEFAULT='LOADED'
## ------------------------------------

APPA_DEBUG=0
APPA_DEBUG_TIMING=0
APPA_DEBUG_ENTRY=0

DIRENV_WARN_TIMEOUT="15s"

if [ "${APPA_DEBUG}" == "1" ] ; then echo "${C_FUNC}"'Loading default configuration'"${C_RST}"; fi

APPA_HOME=$(realpath "${HOME}/com.appalachia")

APPA_SCRIPT_HOME="${APPA_HOME}/appa"
APPA_SERVERS_HOME="${APPA_HOME}/servers"
APPA_NODE_HOME="${APPA_HOME}/node_modules"

APPA_COMMAND_HOME="${APPA_SCRIPT_HOME}/cmd"
APPA_BIN="${APPA_SCRIPT_HOME}/.bin"
APPA_PRIVATE="${APPA_SCRIPT_HOME}/.private"
APPA_SETUP="${APPA_SCRIPT_HOME}/.setup"
APPA_CONFIG_HOME="${APPA_SCRIPT_HOME}/configs"
APPA_FUNCTIONS_HOME="${APPA_SCRIPT_HOME}/functions"

APPA_DESIGN="${APPA_HOME}/design"
APPA_WEB="${APPA_HOME}/web"
APPA_WEB_PUBLIC="${APPA_WEB}/public"
APPA_SVGO_CONFIG="${APPA_DESIGN}/scripts/svgo/config.js"

if git rev-parse --git-dir > /dev/null 2>&1; then
  : 
    REPO_HOME="$(git rev-parse --show-toplevel)"
fi

if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_HOME: ${APPA_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_SCRIPT_HOME: ${APPA_SCRIPT_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_SERVERS_HOME: ${APPA_SERVERS_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_NODE_HOME: ${APPA_NODE_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_BIN: ${APPA_BIN}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_SETUP: ${APPA_SETUP}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_COMMAND_HOME: ${APPA_COMMAND_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_PRIVATE: ${APPA_PRIVATE}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_CONFIG_HOME: ${APPA_CONFIG_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_FUNCTIONS_HOME: ${APPA_FUNCTIONS_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "REPO_HOME: ${APPA_FUNCTIONS_HOME}"; fi

## ------------------------------------
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${suc}Completed loading ${name} configuration.${rst}"; fi
set +a