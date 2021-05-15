#!/bin/bash
# shellcheck source=./../../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

echo "You will be prompted to setup a key.  Use your full name and your @appalachiainteractive.com email address."
echo "When asked for a passphrase, use something that you will remember."

gpg --gen-key

gpg --list-secret-keys

read -p "Enter the email address you used: " address

gpg --export  --armor > public-key.gpg
gpg --export --armor ${address} > "${HOME}/appa-public-key.gpg"