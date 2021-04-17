#!/bin/bash

shopt -s nullglob
opwd=$(pwd)

set -a

APPA_DEBUG=0
APPA_DEBUG_TIMING=0
APPA_DEBUG_ENTRY=0
APPA_SCRIPT_HOME="${0%/*}"
APPA_HOME=$(cd $APPA_SCRIPT_HOME; cd ..; pwd; cd "$opwd")
APPA_COMMAND_HOME="$APPA_SCRIPT_HOME/cmd"
APPA_CONFIG_HOME="$APPA_SCRIPT_HOME/config"
APPA_SERVERS_HOME="$APPA_SCRIPT_HOME/servers"
APPA_FUNCTIONS_HOME="$APPA_SCRIPT_HOME/functions"
APPA_NODE_HOME="$APPA_HOME/node_modules"
REPO_HOME="`git rev-parse --show-toplevel`"

set +a