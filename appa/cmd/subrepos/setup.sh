#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

subrepos_setup()
{
    local opwd="$PWD"
    mapfile -t git_subrepos < <(find "${APPA_HOME}" -mindepth 2 -maxdepth 8 -type f -name .gitsubrepo)

    for git_subrepo in "${git_subrepos[@]}" ; do
        base_dir=$(dirname "${git_subrepo}")

        cd "$base_dir"
        source "$git_subrepo"
        cd "$opwd"
    done

    success "Cloned subrepos!"
}

subrepos_setup "$@"