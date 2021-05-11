#!/bin/bash
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

command="${APPA_BIN}/FileZillaPortable/FileZillaPortable.exe"
echo "> ${command}"

#   [protocol://][user[:pass]@]host[:port][/path]

source "${APPA_COMMAND_HOME}/secrets/export.sh"

protocol="sftp"
user="${APPA_WORDPRESS_SFTP_USER}"
pass="${APPA_WORDPRESS_SFTP_PASS}"
host="sftp.wp.com"
port="22"
remotepath="/htdocs"
#   eg.  sftp://username:password@server:port/remotepath
url="${protocol}://${user}:${pass}@${host}:${port}/$remotepath"

#    -a, --local=<string>
# Sets the local site (left-hand side) to the given path. (Requires version 3.7.1-rc1 or higher)
# Use double quotation for paths with spaces in them.
#
#    Example:
#
#    filezilla --site="0/site1" --local="C:\site1 downloads"
#    filezilla ftp://username:password@ftp.example.com --local="C:\server2 downloads"

baselocalpath=$(echo "$APPA_HOME" |sed -e 's|/c/|C:/|g'  -e 's|/|\\|g' )
args="--local=${baselocalpath}\web\public"

echo "${url}" "${args}"

# filezilla [<FTP URL>]
${command} "${url}" "${args}" &
