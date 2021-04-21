#!/bin/bash

print_border()
{
    echo '________________________________________________________________________________'
}
print_header()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
   
    echo "${C_HEADER}"
    figlet $'APPALACHIA\r\nINTERACTIVE' -f 'Sub-Zero' --horizontal-layout fitted --vertical-layout fitted
    echo "${C_RST}"
    echo ''
}