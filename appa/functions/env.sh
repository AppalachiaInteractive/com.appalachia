#!/bin/bash

check_node_paths()
{
    # Make sure path ends with /
    for directory in "${APPA_NODE_HOME}/.bin/"*; do
        if [[ -d "${directory}" && ! -L "${directory}" ]]; then
            case ":$PATH:" in
                *":$directory:"*) :;; # already there
                *) PATH="$directory:$PATH";;
            esac
        fi
    done
}

check_node()
{   
    if [ ! "$(command -v npm-cli-login)" ]; then
        npm -g install npm-cli-login &> /dev/null
    fi  
}
check_python()
{
    python -m pip check -q
    if [ $? -ne 0 ] ; then    
        if [ -d "./.venv" ] ; then
            if [ -f "requirements.txt" ] ; then
                python -m pip install requirements.txt 
            else 
                python -m pip freeze > requirements.txt
            fi
        else        
            if [ -f "${APPA_HOME}/requirements.txt" ] ; then
                python -m pip install "${APPA_HOME}/requirements.txt"
            else 
                python -m pip freeze > "${APPA_HOME}/requirements.txt"
            fi
        fi
    fi
}