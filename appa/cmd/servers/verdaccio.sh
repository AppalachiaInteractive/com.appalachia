#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi

root="$APPA_SERVERS_HOME/verdaccio"
config="$root/verdaccio.yaml"
command="verdaccio --config $config"

if [ "$APPA_DEBUG" == "1"] ] ; then echo "[ROOT   ] $root"; fi
if [ "$APPA_DEBUG" == "1"] ] ; then echo echo "[CONFIG ] $config"; fi
if [ "$APPA_DEBUG" == "1"] ] ; then echo echo "[COMMAND] $command"; fi

cd "$root"
$command &
pid=$! 
sleep 5 
echo "[Verdaccio] running as PID $pid"
ps -p $pid
