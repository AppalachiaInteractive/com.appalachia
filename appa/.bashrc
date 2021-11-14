#!/bin/bash

shopt -s nullglob

DEBUG_TIMING_OF_BASHRC=0
APPA_HOME=$(realpath "${HOME}/com.appalachia")

export PATH="$APPA_HOME/appa:$PATH"

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------echoing path'; fi
if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo "$PATH"; fi

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------.apparc'; fi
# shellcheck source=./.apparc
source "${APPA_HOME}/appa/.apparc"

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------caching path'; fi

export EDITOR=vim

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------going home'; fi
cd "${APPA_HOME}" || exit

git pull -q

#if [[ -n "$(git status -s)" ]]; then
#    git stash -q 
#    git pull -q
#    git stash apply -q 
#else
#    git pull -q
#fi

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------activating environment'; fi
# shellcheck source=../.venv/Scripts/activate
source "${APPA_HOME}/.venv/Scripts/activate"

source "${APPA_SCRIPT_HOME}/.direnv-fix.sh"

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------direnv hook bash'; fi
eval "$(direnv hook bash)"

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------source bash-preexec.sh'; fi
source "${APPA_SCRIPT_HOME}/bash-preexec.sh"

if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------source .bashprofile'; fi
source "${APPA_SCRIPT_HOME}/.bashprofile"

if [ "$APPA_FAST" != "1" ] ; then

    if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------source wakatime.sh'; fi
    source "${APPA_SCRIPT_HOME}/wakatime.sh"

    if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------check_node'; fi
    check_node

    #if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------check_python'; fi
    #check_python

    if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------reading secrets'; fi
    eval "$(read_secrets | export_secrets)"
else
    export PYTHONPATH="${APPA_HOME}/python/appapy"
fi

if [[ -n "${APPA_PWD}" ]]; then
    echo "${APPA_PWD}"
    cd "${APPA_PWD}" || exit $?    
fi

if [ "$APPA_FAST" != "1" ] ; then
    source "${APPA_SCRIPT_HOME}/welcome.sh";
fi

success "Let's go!"
