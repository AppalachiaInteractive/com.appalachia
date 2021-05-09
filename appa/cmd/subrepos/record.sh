 #!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

mapfile -t git_dirs < <(find "${APPA_HOME}" -mindepth 2 -maxdepth 8 -type d -name .git)

echo
for git_dir in "${git_dirs[@]}" ; do
    echo
    echo "--------------------"
    base_dir=$(dirname "${git_dir}")

    base_name=$(basename "${base_dir}")
    parent_dir=$(dirname "${base_dir}")

    subrepo="${parent_dir}/.gitsubrepo"
    ignore="${parent_dir}/.gitignore"

    
    remote=$(git --git-dir "${git_dir}" --work-tree "${base_dir}" remote get-url origin)

    #echo "$remote"

    command_clone=$'if [ ! -d '"$base_name"' ] ; then git clone '"${remote}"' '"${base_name}"'; fi'

    #echo "$command_clone"

    echo "$command_clone" >> "$subrepo"
    cat -n "$subrepo" | grep 'git clone' | sort -uk2 | sort -n | cut -f2- > "$subrepo"

    echo "${base_name}" >> "$ignore"
    cat -n "$ignore" | grep -v 'echo' | sort -uk2 | sort -n | cut -f2- > "$ignore"

    cat "$subrepo"
    cat "$ignore"
    echo "--------------------"
done
