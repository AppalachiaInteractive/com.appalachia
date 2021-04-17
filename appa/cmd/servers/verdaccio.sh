#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi



cd $APPA_SERVERS_HOME/verdaccio
verdaccio &
sleep 1 
ps -p $!