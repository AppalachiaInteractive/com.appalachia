#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

attempt "Attempting to download wordpress CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar "${APPA_BIN}/wp"

if wp --info;
then
    success "Successfully installed wordpress CLI!"
else
    failure "Failed to install wordpress CLI!"
fi
