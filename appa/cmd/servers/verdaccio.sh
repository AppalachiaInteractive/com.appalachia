#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

root="$APPA_SERVERS_HOME/verdaccio"
config="$root/verdaccio.yaml"
command="verdaccio --config $config"

if [ "$APPA_DEBUG" == "1" ] ; then echo "[ROOT   ] $root"; fi
if [ "$APPA_DEBUG" == "1" ] ; then echo "[CONFIG ] $config"; fi
if [ "$APPA_DEBUG" == "1" ] ; then echo "[COMMAND] $command"; fi

cd "$root" || exit
$command &
pid=$! 
sleep 5 
echo "[Verdaccio] running as PID $pid"
ps -p $pid
