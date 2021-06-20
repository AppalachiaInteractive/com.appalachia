#!/bin/bash

# only run this to install the appa framework to your environment.


echo "This will modify your .bashrc file.  Press CTRL+C now to cancel, or enter 'x'.  Just hit enter to continue."
read throwaway

if [ "${throwaway}" == "x" ] || [ "${throwaway}" == "X" ] ; then
    echo "Sorry about that.  Exiting now."
    exit 1
fi

if command -v appa &> /dev/null
then
    echo "You have already setup your environment.  Go away."
    exit 1
fi

echo '. "${HOME}/com.appalachia/appa/.bashrc"' >> "${HOME}/.bashrc"

note "What is your name?"

read varname

echo "${varname}" > .name

success "Initialized."
note "Restart your shell!  Then run 'appa install'."
