#!/bin/bash
name="colors";
shopt -s nullglob;
set -a
APPA_CONFIG_COLORS='LOADED'
## ------------------------------------
# ┌───────┬────────────────┬─────────────────┐   ┌───────┬─────────────────┬───────┐
# │ Fg/Bg │ Color          │ Octal           │   │ Code  │ Style           │ Octal │
# ├───────┼────────────────┼─────────────────┤   ├───────┼─────────────────┼───────┤
# │  K/k  │ Black          │ \e[ + 3/4  + 0m │   │  s/S  │ Bold (strong)   │ \e[1m │
# │  R/r  │ Red            │ \e[ + 3/4  + 1m │   │  d/D  │ Dim             │ \e[2m │
# │  G/g  │ Green          │ \e[ + 3/4  + 2m │   │  i/I  │ Italic          │ \e[3m │
# │  Y/y  │ Yellow         │ \e[ + 3/4  + 3m │   │  u/U  │ Underline       │ \e[4m │
# │  B/b  │ Blue           │ \e[ + 3/4  + 4m │   │  f/F  │ Blink (flash)   │ \e[5m │
# │  M/m  │ Magenta        │ \e[ + 3/4  + 5m │   │  n/N  │ Negative        │ \e[7m │
# │  C/c  │ Cyan           │ \e[ + 3/4  + 6m │   │  h/H  │ Hidden          │ \e[8m │
# │  W/w  │ White          │ \e[ + 3/4  + 7m │   │  t/T  │ Strikethrough   │ \e[9m │
# ├───────┴────────────────┴─────────────────┤   ├───────┼─────────────────┼───────┤
# │  High intensity        │ \e[ + 9/10 + *m │   │   0   │ Reset           │ \e[0m │
# └────────────────────────┴─────────────────┘   └───────┴─────────────────┴───────┘
#                                                 Uppercase = Reset a style: \e[2*m
#
FG_BLACK="\e[30m"
FG_RED="\e[31m"
FG_GREEN="\e[32m"
FG_YELLOW="\e[33m"
FG_BLUE="\e[34m"
FG_MAGENTA="\e[35m"
FG_CYAN="\e[36m"
FG_WHITE="\e[37m"
FG_DEFAULT="\e[39m"
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_WHITE="\e[47m"
BG_DEFAULT="\e[49m"
ST_BOLD="\e[1m"
ST_DIM="\e[2m"
ST_ITALIC="\e[3m"
ST_UNDERLINE="\e[4m"
ST_BLINK="\e[5m"
ST_NEGATIVE="\e[7m"
ST_HIDDEN="\e[8m"
ST_STRIKE="\e[9m"
RESET="\e[0m"

c() { [ $# == 0 ] && printf "\e[0m" || printf "$1" | sed 's/\(.\)/\1;/g;s/\([SDIUFNHT]\)/2\1/g;s/\([KRGYBMCWX]\)/3\1/g;s/\([krgybmcwx]\)/4\1/g;y/SDIUFNHTsdiufnhtKRGYBMCWXkrgybmcwx/1234578912345789012345679012345679/;s/^\(.*\);$/\\e[\1m/g'; }
cecho() { if [ "$APPA_FAST" != "1" ] ; then echo -e "$(c $1)${2}\e[0m"; else echo "${2}"; fi }
cechon() { if [ "$APPA_FAST" != "1" ] ; then echo -e -n "$(c $1)${2}\e[0m"; else echo "${2}"; fi }
warn() { cecho "sKy" "\n\n${1}\n "; if [ "$APPA_FAST" != "1" ] ; then sleep .35; fi }
warning() { warn "$1"; }
error() { cecho "sXr" "\n\n${1}\n "; if [ "$APPA_FAST" != "1" ] ; then sleep .5; fi }
debug_cat() { if [ "${APPA_DEBUG}" == "1" ] ; then cat "${1}  "; fi; }
debug(){ if [ "${APPA_DEBUG}" == "1" ] ; then cecho "dXy" "${1}  "; fi; }
attempt() { cecho "sCx" "${1}  "; }
note() { cecho "Mx" "${1}  "; }
success() { cecho "sGx" "${1}  "; }
header() { cecho "sYx" "${1}  "; }
echo_cmd() { cecho "sXc" "${1}  "; }
echo_cmd_header() { cecho "sKb" "${1}  "; }
echo_cmd_family() { cecho "sKc" "${1}  "; }
echo_func() { cecho "iYx" "${1}  "; }
value() { cecho "sKm" "${1}  "; }
args() { cecho "sWb" "${1}  "; }
argserror() { cecho "sXr" "${1}  "; }
highlight() { cecho "sYx" "${1}  "; }
highlight1() { cecho "sYx" "${1}  "; }
highlight2() { cecho "sBx" "${1}  "; }
highlight3() { cecho "sCx" "${1}  "; }
highlight4() { cecho "sMx" "${1}  "; }
subtle() { cecho "dXx" "${1}  "; }

## ------------------------------------
if [ "${APPA_DEBUG}" == "1" ] ; then success "Completed loading ${name} configuration."; fi
set +a

