#!/bin/bash

# Using _ as the delimiter, sed will make the following replacements:
# \     ->   /
# A:    ->   /a
# B:    ->   /b
# C:    ->   /c
# D:    ->   /d
# E:    ->   /e
# ;     ->   :
# /c/Program Files/Git/ -> /
# :/usr/bin:/usr/bin:   -> :/usr/bin:/bin:

ls > /dev/null
result=$?

# If the command failed, we are broken:
if [ $result -ne 0 ] ; then
    direnv_new_path="${PATH}"        # cache the current (broken) path.
    # Restoring path
    . "${APPA_SCRIPT_HOME}/.path"
    export PATH=$(echo "${direnv_new_path}" | sed -e 's_\\_/_g' -e 's_A:_/a_g' -e 's_B:_/b_g' -e 's_C:_/c_g' -e 's_D:_/d_g' -e 's_E:_/e_g' -e 's_;_:_g' -e 's_/c/Program Files/Git/_/_g' -e 's_:/usr/bin:/usr/bin:_:/usr/bin:/bin:_g' )

# If we should fix the path:
elif [ "${DIRENV_FIX_PATH}" == "1" ] ; then  
    direnv_new_path="${PATH}"        # cache the current (broken) path.
    # Reset the path to the original, so that we have access to sed.
    export PATH="${DIRENV_OLD_PATH}" # Then fix and re-set the new path.

    export PATH=$(echo "${direnv_new_path}" | sed -e 's_\\_/_g' -e 's_A:_/a_g' -e 's_B:_/b_g' -e 's_C:_/c_g' -e 's_D:_/d_g' -e 's_E:_/e_g' -e 's_;_:_g' -e 's_/c/Program Files/Git/_/_g' -e 's_:/usr/bin:/usr/bin:_:/usr/bin:/bin:_g' )

fi

ls > /dev/null
result=$?
if [ $result -ne 0 ] ; then
    # Restoring path
    . "${APPA_SCRIPT_HOME}/.path"
fi