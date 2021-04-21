#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"


git push
git push --tags

package=`appa vars package_end`

echo "Outputting [appa.vsix] to [$PWD]"
vsce package -o appa.vsix

