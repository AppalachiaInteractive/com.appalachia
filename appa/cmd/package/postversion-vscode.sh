#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"


git push
git push --tags

pkg=`appa vars package_end`

echo "Outputting [$pkg.vsix] to [$PWD]"
vsce package -o "$pkg.vsix"

