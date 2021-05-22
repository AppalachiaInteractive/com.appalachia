#!/usr/bin/env bash

declare -a threading_pids
declare -a threading_descs

clearPids() {
    threading_pids=();
    threading_descs=();
}

waitPids() {
    local sleepDelay=${1-1}

    while [ ${#threading_pids[@]} -ne 0 ]; do

        for i in ${!threading_pids[@]}; do
            if ! kill -0 "${threading_pids[$i]}" 2> /dev/null; then
                echo "[DONE] [${threading_descs[$i]}] [${threading_pids[$i]}]"
                unset 'threading_pids[i]'
                unset 'threading_descs[i]'
            fi
        done

        # Expunge nulls created by unset.
        threading_pids=("${threading_pids[@]}")
        threading_descs=("${threading_descs[@]}")

        echo "[WAITING] -------------------------------------------[$(date)]"
        for i in ${!threading_pids[@]}; do
            echo "[WAITING] [${threading_descs[$i]}] [${threading_pids[$i]}]"
        done
        
        sleep $sleepDelay;

    done
    echo "Done!"
}

addPid() {
    local pid="$1"
    local desc="${2// /_}"
    threading_pids=(${threading_pids[@]} $pid)
    threading_descs=(${threading_descs[@]} "${desc}")
}
