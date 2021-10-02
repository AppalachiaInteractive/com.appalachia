#!/bin/bash

check_node()
{
    for x in "${APPA_NODE_HOME}/.bin"; do
    case ":$PATH:" in
        *":$x:"*) :;; # already there
        *) PATH="$x:$PATH";;
    esac
    done

    npm -g install npm-cli-login &> /dev/null
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