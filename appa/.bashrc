#!/bin/bash

shopt -s nullglob

root="${HOME}/com.appalachia"
source "${root}/appa/.apparc"

export EDITOR=vim

echo "export PATH='${PATH}'" > "${APPA_SCRIPT_HOME}/.path"

cd "${APPA_HOME}"

source "${APPA_HOME}/.venv/Scripts/activate"

preexec() 
{ 
    source "${APPA_SCRIPT_HOME}/preexec.sh" 
}
precmd() 
{ 
    source "${APPA_SCRIPT_HOME}/precmd.sh"
}

eval "$(direnv hook bash)"

source "${APPA_SCRIPT_HOME}/bash-preexec.sh"
source "${APPA_SCRIPT_HOME}/wakatime.sh"
source "${APPA_SCRIPT_HOME}/.bashprofile"
