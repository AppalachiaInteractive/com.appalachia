#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

echo "${C_NOTE}Setting up repository...${C_RST}"

python -m appapy templating
res=$?
if [ $res -eq 0 ]
then
    #rm -- "$0"
    echo "${C_SUC}Repository setup complete...${C_RST}"
else
    echo "${C_ERR}Issue setting up repository...${C_RST}"
    exit $res
fi
