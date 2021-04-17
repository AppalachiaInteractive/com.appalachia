#!/bin/bash
if [ "$APPA_DEBUG_ENTRY" == "1" ] ; then echo "$0"; fi



source .venv/Scripts/activate
python -m pip install -r requirements.txt
./servers.sh