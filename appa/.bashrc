#!/bin/bash

shopt -s nullglob

DEBUG_TIMING_OF_BASHRC=0
APPA_HOME=$(realpath "${HOME}/com.appalachia")

export PATH="$APPA_HOME/appa:$PATH"

debug_log() {
    if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------'"${1}"; fi
}

debug_log 'echoing path'
debug_log "$PATH";
debug_log '.apparc'

# shellcheck source=./.apparc
source "${APPA_HOME}/appa/.apparc"

debug_log 'caching path'
export EDITOR=vim

debug_log 'going home'
cd "${APPA_HOME}" || exit

git fetch
git pull -q

debug_log 'activating environment'
# shellcheck source=../.venv/Scripts/activate
source "${APPA_HOME}/.venv/Scripts/activate"

source "${APPA_SCRIPT_HOME}/.direnv-fix.sh"

debug_log 'direnv hook bash'
eval "$(direnv hook bash)"

debug_log 'source bash-preexec.sh'
source "${APPA_SCRIPT_HOME}/bash-preexec.sh"

debug_log 'source .bashprofile'
source "${APPA_SCRIPT_HOME}/.bashprofile"

if [ "$APPA_FAST" != "1" ] ; then

    debug_log 'source wakatime.sh'
    source "${APPA_SCRIPT_HOME}/wakatime.sh"

    debug_log 'check_node_paths'
    check_node_paths

    debug_log 'check_node'
    check_node

    #debug_log 'check_python'
    #check_python

    debug_log 'reading secrets'
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

success "Development environment loaded!"
