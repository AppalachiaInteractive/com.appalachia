#!/bin/bash

shopt -s nullglob

root="${HOME}/com.appalachia"
source "${root}/appa/.apparc"

export EDITOR=vim

name=$(cat "${APPA_SCRIPT_HOME}/.name")
banner=$(figlet "${name}" -f Sub-Zero --horiziontal-layout fitted | sed -e 1's/.*'"/\\${FG_RED} &/" -e 2's/.*'"/\\${FG_YELLOW} &/" -e 3's/.*'"/\\${FG_GREEN} &/" -e 4's/.*'"/\\${FG_CYAN} &/" -e 5's/.*'"/\\${FG_BLUE} &/")
echo -n -e "${banner}"$'\n'


eval "$(direnv hook bash)"

preexec() 
{ 
    source "${APPA_SCRIPT_HOME}/preexec.sh" 
}
precmd() 
{ 
    source "${APPA_SCRIPT_HOME}/precmd.sh"
}

source "${APPA_SCRIPT_HOME}/bash-preexec.sh"
source "${APPA_SCRIPT_HOME}/wakatime.sh"
source "${APPA_SCRIPT_HOME}/.bashprofile"
