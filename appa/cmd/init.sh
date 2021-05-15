#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"


source .venv/Scripts/activate
python -m pip install -r requirements.txt
./servers.sh