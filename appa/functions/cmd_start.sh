#!/bin/bash

if [ "$APPA_DEBUG" == "1" ] || [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "${C_FUNCS}$0${RESET}"; fi
if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_ARGS}[ARGS] [#: $#] $@${RESET}"; fi
