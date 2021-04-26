#!/bin/bash

if [ "${APPA_DEBUG}" == "1" ] || [ "${APPA_DEBUG_ENTRY}" == "1" ] ; then echo "${C_FUNC}$0${RESET}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${C_ARGS}[ARGS] [#: $#] $@${RESET}"; fi

if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_HOME: ${APPA_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_SCRIPT_HOME: ${APPA_SCRIPT_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_SERVERS_HOME: ${APPA_SERVERS_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_NODE_HOME: ${APPA_NODE_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_COMMAND_HOME: ${APPA_COMMAND_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_CONFIG_HOME: ${APPA_CONFIG_HOME}"; fi
if [ "${APPA_DEBUG}" == "1" ] ; then echo "APPA_FUNCTIONS_HOME: ${APPA_FUNCTIONS_HOME}"; fi
