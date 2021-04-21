#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"


echo 'Setting up repository...'
python "$APPA_HOME/python/temp-py/main.py"
if [ $? -eq 0 ]
then
    #rm -- "$0"
    echo 'Repository setup complete...'
else
    echo 'Issue setting up repository...'
fi