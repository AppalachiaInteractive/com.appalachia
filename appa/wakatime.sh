# wakatime for bash
#
# include this file in your "~/.bashrc" file with this command:
#   . path/to/bash-wakatime.sh
#
# or this command:
#   source path/to/bash-wakatime.sh
#
# Don't forget to create and configure your "~/.wakatime.cfg" file.

debug_log() {
    if [ "${DEBUG_TIMING_OF_BASHRC}" == "1" ] ; then echo '------------------------------'"${1}"; fi
}

# hook function to send wakatime a tick
wakatime_preprompt_command() {
    debug_log 'wakatime.wakatime_preprompt_command starting.'
    version="1.0.0"
    entity=$(echo $(fc -ln -0) | cut -d ' ' -f1)
    [ -z "${entity}" ] && return # ${entity} is empty or only whitespace
    $(git rev-parse --is-inside-work-tree 2> /dev/null) && local project="$(basename $(git rev-parse --show-toplevel))" || local project="Terminal"
    (wakatime --write --plugin "bash-wakatime/${version}" --entity-type app --project "${project}" --entity "${entity}" --language "Bash" 2>&1 > /dev/null &)

    debug_log 'wakatime.wakatime_preprompt_command ending.'
}

PROMPT_COMMAND=$'\n'"wakatime_preprompt_command;${PROMPT_COMMAND}"
