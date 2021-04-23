#!/bin/bash

shopt -s nullglob
opwd=$(pwd)

set -a

APPA_DEBUG=0
APPA_DEBUG_TIMING=0
APPA_DEBUG_ENTRY=0


FG_BLACK=`tput setf 0`
FG_RED=`tput setf 4`
FG_GREEN=`tput setf 2`
FG_YELLOW=`tput setf 6`
FG_BLUE=`tput setf 1`
FG_MAGENTA=`tput setf 5`
FG_CYAN=`tput setf 3`
FG_WHITE=`tput setf 7`
BG_BLACK=`tput setb 0`
BG_RED=`tput setb 4`
BG_GREEN=`tput setb 2`
BG_YELLOW=`tput setb 6`
BG_BLUE=`tput setb 1`
BG_MAGENTA=`tput setb 5`
BG_CYAN=`tput setb 3`
BG_WHITE=`tput setb 7`
RESET=`tput sgr0`

C_NOTE="${FG_CYAN}"
C_FUNCS="${FG_GREEN}"
C_FUNC="${FG_YELLOW}"
C_SUC="${FG_GREEN}"
C_ERR="${FG_RED}"
C_VAL="${FG_MAGENTA}"
C_ARGS="${BG_BLUE}${FG_WHITE}"
C_ARGSERR="${BG_RED}${FG_BLACK}"
C_HEADER="${BG_BLACK}${FG_YELLOW}"
C_CMD="${BG_BLACK}${FG_GREEN}"
C_CMDF="${BG_BLACK}${FG_CYAN}"
C_RST="${RESET}"


if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}"'Loading default configuration'"${C_RST}"; fi

APPA_SCRIPT_HOME="${0%/*}"
APPA_HOME=$(cd $APPA_SCRIPT_HOME; cd ..; pwd; cd "$opwd")
APPA_COMMAND_HOME="$APPA_SCRIPT_HOME/cmd"
APPA_CONFIG_HOME="$APPA_SCRIPT_HOME/config"
APPA_SERVERS_HOME="$APPA_HOME/servers"
APPA_FUNCTIONS_HOME="$APPA_SCRIPT_HOME/functions"
APPA_NODE_HOME="$APPA_HOME/node_modules"
REPO_HOME="`git rev-parse --show-toplevel`"


set +a