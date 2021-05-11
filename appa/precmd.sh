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

precmd() {        
    trap 'catch $? $LINENO' ERR

    catch() {         
        # error handling goes here        
        direnv_new_path="$PATH"        # cache the current (broken) path.
        # Restoring path
        source "${APPA_SCRIPT_HOME}/.path"
        PATH=$(echo "${direnv_new_path}" | sed -e 's_\\_/_g' -e 's_A:_/a_g' -e 's_B:_/b_g' -e 's_C:_/c_g' -e 's_D:_/d_g' -e 's_E:_/e_g' -e 's_;_:_g' -e 's_/c/Program Files/Git/_/_g' -e 's_:/usr/bin:/usr/bin:_:/usr/bin:/bin:_g' )
        export PATH
        #echo "Did we save it?"
        ls &> /dev/null
    }
    
    ls &> /dev/null
    return $?
}