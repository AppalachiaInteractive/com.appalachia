#!/usr/bin/env bash
#/ secrets_usage: secrets.sh <operation> [<key> [<value]]
#/
#/ Simple secrets manager in bash using GPG
#/
#/   Store a secret:    secrets.sh set my_secret_key my_secret
#/            ...or:    secrets.sh set my_secret_key
#/   Retrieve a secret: secrets.sh get my_secret_key
#/   Forget a secret:   secrets.sh del my_secret_key
#/   List all secrets:  secrets.sh list
#/   Dump database:     secrets.sh dump
#/
# Copyright (c) 2018 Jordan Webb
#  - secrets_urlencode by Brian K. White
#  - secrets_urldecode by Chris Down
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e
set -o pipefail

secrets_usage()
{
  grep "^#/" <"${APPA_FUNCTIONS_HOME}/secrets.sh" | cut -c4-
}

#/ By default, the file $HOME/.secrets will be used to store secrets. If
#/ you prefer, set the SECRETS_PATH in your environment to a different path.
#/
SECRETS_PATH=${SECRETS_PATH:-"$HOME/.secrets"}

#/ To use a specific gpg binary, set SECRETS_GPG_PATH.
if [ -z "$SECRETS_GPG_PATH" ] ; then
  if [ -n "$(type -P gpg2)" ] ; then
    SECRETS_GPG_PATH="$(type -P gpg2)"
  elif [ -n "$(type -P gpg)" ] ; then
    SECRETS_GPG_PATH="$(type -P gpg)"
  else
    echo "ERROR: couldn't find gpg on PATH, do you need to set SECRETS_GPG_PATH?" >&2
    secrets_usage
    exit 1
  fi
fi

#/ To pass extra arguments to GPG, set SECRETS_GPG_ARGS.
SECRETS_GPG_ARGS=${SECRETS_GPG_ARGS:-""}

#/ To use a specific GPG key, set SECRETS_GPG_KEY to the key ID.
if [ -n "$SECRETS_GPG_KEY" ] ; then
  SECRETS_GPG_ARGS="$SECRETS_GPG_ARGS --default-key $SECRETS_GPG_KEY"
fi

if [ -z "$COLUMNS" ] ; then
  if [ -t 1 ] ; then
    COLUMNS=$(tput cols)
  else
    COLUMNS=72
  fi
fi

SECRETS_LIST_FORMAT=${SECRETS_LIST_FORMAT:-"%-$((COLUMNS - 26))s | %s"}
SECRETS_DATE_FORMAT=${SECRETS_DATE_FORMAT:-"%F %I:%M%p %Z"}

set +e
secrets_require_args()
{
  set -e
  local operation=$1 have=$2 want=$3
  if [ "$want" -ne "$have" ] ; then
    echo "ERROR: incorrect number of arguments for '$operation'" >&2
    exit 1
  fi
  set +e
}

secrets_urlencode()
{ 
  set -e
  local LANG=C i c e=''
  for ((i=0;i<${#1};i++)) ; do
    c=${1:$i:1}
    [[ "$c" =~ [a-zA-Z0-9\.\~\_\-] ]] || printf -v c '%%%02X' "'$c"
    e+="$c"
  done
  echo "$e"
  set +e
}

secrets_urldecode()
{
  set -e
  local url_encoded="${1//+/ }"
  printf '%b' "${url_encoded//%/\\x}"
  set +e
}

read_secrets()
{
  set -e
  if [ -e "$SECRETS_PATH" ] ; then
    local fifo_dir
    fifo_dir=$(mktemp -d)

    local status_fifo="$fifo_dir/status.$RANDOM"
    mkfifo -m 0600 "$status_fifo"
    exec 3<>"$status_fifo"
    exec 4<"$status_fifo"

    local logger_fifo="$fifo_dir/logger.$RANDOM"
    mkfifo -m 0600 "$logger_fifo"
    exec 5<>"$logger_fifo"
    exec 6<"$logger_fifo"

    local output_fifo="$fifo_dir/output.$RANDOM"
    mkfifo -m 0600 "$output_fifo"
    exec 7<>"$output_fifo"
    exec 8<"$output_fifo"

    rm -rf "$fifo_dir"
    local gpg_status=0
    $SECRETS_GPG_PATH -q $SECRETS_GPG_ARGS --with-colons \
      --status-fd 3 --logger-fd 5 \
      --decrypt < "$SECRETS_PATH" >&7 || gpg_status=$?

    exec 3>&-
    exec 5>&-
    exec 7>&-

    if [ "$gpg_status" != "0" ] ; then
      cat - <&6 >&2
      exit $gpg_status
    fi

    local decrypt_key='' verify_key='' gpg_op
    while read -u 4
    do
      gpg_op=$(cut -d' ' -f2 <<< "$REPLY")
      if [ "$gpg_op" = "DECRYPTION_KEY" ] ; then
        decrypt_key=$(cut -d' ' -f4 <<< "$REPLY")
      elif [ "$gpg_op" = "VALIDSIG" ] ; then
        verify_key=$(cut -d' ' -f12 <<< "$REPLY")
      fi
      if [ -n "$decrypt_key" ] && [ -n "$verify_key" ] ; then
        break
      fi
    done

    if [ -z "$verify_key" ] ; then
      echo "ERROR: $SECRETS_PATH doesn't appear to be signed" >&2
      exit 1
    elif [ "$verify_key" != "$decrypt_key" ] ; then
      echo "ERROR: different keys used to sign and to encrypt $SECRETS_PATH" >&2
      exit 1
    fi

    cat - <&8
  fi
  set +e
}

write_secrets()
{
  set -e
  local fifo_dir
  fifo_dir=$(mktemp -d)

  local logger_fifo="$fifo_dir/logger.$RANDOM"
  mkfifo -m 0600 "$logger_fifo"
  exec 9<>"$logger_fifo"
  exec 10<"$logger_fifo"

  local output_fifo="$fifo_dir/output.$RANDOM"
  mkfifo -m 0600 "$output_fifo"
  exec 11<>"$output_fifo"
  exec 12<"$output_fifo"

  rm -rf "$fifo_dir"
  local gpg_status=0
  $SECRETS_GPG_PATH $SECRETS_GPG_ARGS --default-recipient-self -z 9 --armor \
    --logger-fd 9 --sign --encrypt >&11 || gpg_status=$?

  exec 9>&-
  exec 11>&-

  if [ "$gpg_status" != "0" ] ; then
    cat - <&10 >&2
    exit $gpg_status
  fi

  cat - <&12 > "$SECRETS_PATH"
  set +e
}

list_secrets()
{
  set -e
  local this_key this_date this_value
  while read this_key this_date this_value
  do
    this_key=$(secrets_urldecode "$this_key")
    printf "$SECRETS_LIST_FORMAT\n" "$this_key" "$(date +"$SECRETS_DATE_FORMAT" --date="@$this_date")"
  done
  set +e
}

export_secrets()
{
  set -e
  local this_key this_date this_value
  while read this_key this_date this_value
  do
    this_key=$(secrets_urldecode "$this_key")
    echo "${this_key}=${this_value}"
  done
  set +e
}

extract_secret()
{
  set -e
  local key=$1 this_key this_date this_value
  while read this_key this_date this_value
  do
    this_key=$(secrets_urldecode "$this_key")
    this_value=$(secrets_urldecode "$this_value")
    if [ "$this_key" = "$key" ] ; then
      printf "%s\n" "$this_value"
      break
    fi
  done
  set +e
}

filter_secret()
{
  set -e
  local key=$1 this_key this_date this_value
  while read this_key this_date this_value
  do
    if [ -z "$this_key" ] ; then
      break
    fi

    local decoded_key=$(secrets_urldecode "$this_key")
    if [ "$decoded_key" != "$key" ] ; then
      printf "%q %q %q\n" "$this_key" "$this_date" "$this_value"
    fi
  done
  set +e
}



#/
#/ For more information, see https://github.com/jordemort/secrets.sh
