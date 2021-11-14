#!/bin/bash
name="bash";
shopt -s nullglob; fg=$(tput setf 3); suc=$(tput setf 2); rst=$(tput sgr0);
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${fg}Loading ${name} configuration...${rst}"; fi
set -a
APPA_CONFIG_BASH='LOADED'
## ------------------------------------

GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose