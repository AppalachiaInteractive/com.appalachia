#!/usr/bin/env bash

# Usage: animate framesArray interval
function animate () {
    local frames=("$@")

    ((lastIndex=${#frames[@]} - 1))
    local mode=${frames[lastIndex]}
    unset frames[lastIndex]

    ((lastIndex=${#frames[@]} - 1))
    local interval=${frames[lastIndex]}
    unset frames[lastIndex]

    # Comment out next two lines if you are using CTRL+C event handler.
    trap 'tput cnorm; echo' EXIT
    trap 'exit 127' HUP INT TERM

    tput civis # hide cursor
    tput sc # save cursor position

    tput civis # hide cursor
    tput sc # save cursor position

    index=0
    max="${#frames[@]}"
    indices=()
    direction="forward"
    forwardIndices=( $(seq 0 1 "${max}") )
    backwardIndices=( $(seq "${max}" -1 0) )

    while true; do
        if [ "${mode}" = "circular" ]; then
            direction="forward"
        elif [ "${mode}" = "pendular" ]; then
            if (( index >= max )); then
                direction="backward"
            elif (( index <= 0 )); then
                direction="forward"
            fi
        else
            echo "Wrong mode! Valid modes: circular, pendular"
            exit 255
        fi

        if [ "${direction}" = "forward" ]; then
            indices=( "${forwardIndices[@]}" )
        else
            indices=( "${backwardIndices[@]}" )
        fi
        

        for index in "${indices[@]}"; do
            tput rc # restore cursor position
            echo "${frames[$index]}"
            sleep "${interval}"
        done
    done
}


# Usage: pacMan inputString interval pad
# Example: pacman "Hello World" 0.5 "*"
function pacMan () {
    local string="${1}"
    local interval="${2}"
    : "${interval:=0.2}"
    local pad="${3}"
    : "${pad:=.}"
    local length=${#string}
    local padding=""

    # Comment out next two lines if you are using CTRL+C event handler.
    trap 'tput cnorm; echo' EXIT
    trap 'exit 127' HUP INT TERM

    tput civis # hide cursor
    tput sc # save cursor position

    for((i=0;i<=length;i++)); do
        tput rc
        echo "${padding}c${string:i:length}"
        sleep "$interval"
        tput rc
        echo "${padding}C${string:i:length}"
        sleep "${interval}"
        padding+="${pad}"
    done

    tput cnorm
    tput rc
    echo "${padding}"
}

# Usage: bannerColor "my title" "red" "*"
function bannerColor() {
    case ${2} in
        black) color=0
        ;;
        red) color=1
        ;;
        green) color=2
        ;;
        yellow) color=3
        ;;
        blue) color=4
        ;;
        magenta) color=5
        ;;
        cyan) color=6
        ;;
        white) color=7
        ;;
        *) echo "color is not set"; exit 1
        ;;
    esac

    local msg="${3} ${1} ${3}"
    local edge=$(echo "${msg}" | sed "s/./${3}/g")
    tput setaf ${color}
    tput bold
    echo "${edge}"
    echo "${msg}"
    echo "${edge}"
    tput sgr 0
    echo
}

# Usage: bannerSimple "my title" "*"
function bannerSimple() {
    local msg="${2} ${1} ${2}"
    local edge=$(echo "${msg}" | sed "s/./"${2}"/g")
    echo "${edge}"
    echo "$(tput bold)${msg}$(tput sgr0)"
    echo "${edge}"
    echo
}

# Usage: import "mylib"
function import() {
    local file="./lib/${1}.sh"
    if [ -f "${file}" ]; then
        source "${file}"
    else
        echo "Error: Cannot find library at: ${file}"
        exit 1
    fi
}

# Usage: options=("one" "two" "three"); inputChoice "Choose:" 1 "${options[@]}"; choice=$?; echo "${options[$choice]}"
function inputChoice() {
    echo "${1}"; shift
    echo $(tput dim)-"Change option: [up/down], Select: [ENTER]" $(tput sgr0)
    local selected="${1}"; shift

    ESC=$(echo -e "\033")
    cursor_blink_on()  { tput cnorm; }
    cursor_blink_off() { tput civis; }
    cursor_to()        { tput cup $(($1-1)); }
    print_option()     { echo $(tput sgr0) "$1" $(tput sgr0); }
    print_selected()   { echo $(tput rev) "$1" $(tput sgr0); }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2; [[ $key = $ESC[A ]] && echo up; [[ $key = $ESC[B ]] && echo down; [[ $key = "" ]] && echo enter; }

    for opt; do echo; done

    local lastrow=$(get_cursor_row)
    local startrow=$(($lastrow - $#))
    trap "cursor_blink_on; echo; echo; exit" 2
    cursor_blink_off

    : selected:=0

    while true; do
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ ${idx} -eq ${selected} ]; then
                print_selected "${opt}"
            else
                print_option "${opt}"
            fi
            ((idx++))
        done

        case $(key_input) in
            enter) break;;
            up)    ((selected--)); [ "${selected}" -lt 0 ] && selected=$(($# - 1));;
            down)  ((selected++)); [ "${selected}" -ge $# ] && selected=0;;
        esac
    done

    cursor_to "${lastrow}"
    cursor_blink_on
    echo

    return "${selected}"
}

# Usage: multiChoice "header message" resultArray "comma separated options" "comma separated default values"
# Credit: https://serverfault.com/a/949806
# TODO: 1) Refactoring to return result array 2) Get input options as array
function multiChoice {
    echo "${1}"; shift
    echo $(tput dim)-"Change Option: [up/down], Change Selection: [space], Done: [ENTER]" $(tput sgr0)
    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "$ESC[?25h"; }
    cursor_blink_off()  { printf "$ESC[?25l"; }
    cursor_to()         { printf "$ESC[$1;${2:-1}H"; }
    print_inactive()    { printf "$2   $1 "; }
    print_active()      { printf "$2  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()         {
        local key
        IFS= read -rsn1 key 2>/dev/null >&2
        if [[ $key = ""      ]]; then echo enter; fi;
        if [[ $key = $'\x20' ]]; then echo space; fi;
        if [[ $key = $'\x1b' ]]; then
            read -rsn2 key
            if [[ $key = [A ]]; then echo up;    fi;
            if [[ $key = [B ]]; then echo down;  fi;
        fi
    }
    toggle_option()    {
        local arr_name=$1
        eval "local arr=(\"\${${arr_name}[@]}\")"
        local option=$2
        if [[ ${arr[option]} == 1 ]]; then
            arr[option]=0
        else
            arr[option]=1
        fi
        eval $arr_name='("${arr[@]}")'
    }

    local retval=$1
    local options
    local defaults

    IFS=';' read -r -a options <<< "$2"
    if [[ -z $3 ]]; then
        defaults=()
    else
        IFS=';' read -r -a defaults <<< "$3"
    fi

    local selected=()

    for ((i=0; i<${#options[@]}; i++)); do
        selected+=("${defaults[i]}")
        printf "\n"
    done

    # determine current screen position for overwriting the options
    local lastrow=$(get_cursor_row)
    local startrow=$(($lastrow - ${#options[@]}))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local active=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for option in "${options[@]}"; do
            local prefix="[ ]"
            if [[ ${selected[idx]} == 1 ]]; then
                prefix="[x]"
            fi

            cursor_to $(($startrow + $idx))
            if [ $idx -eq $active ]; then
                print_active "$option" "$prefix"
            else
                print_inactive "$option" "$prefix"
            fi
            ((idx++))
        done

        # user key control
        case $(key_input) in
            space)  toggle_option selected $active;;
            enter)  break;;
            up)     ((active--));
                if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            down)   ((active++));
                if [ $active -ge ${#options[@]} ]; then active=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    indices=()
    for((i=0;i<${#selected[@]};i++)); do
        if ((${selected[i]} == 1)); then
            indices+=(${i})
        fi
    done

    # eval $retval='("${selected[@]}")'
    eval $retval='("${indices[@]}")'
}

# Usage: average int1 int2 ...
function average () {
    local sum=0
    for int in $@; do
        ((sum += int))
    done
    echo $((sum / $#))
}

# Usage: product int1 int2 ...
function product () {
    local result=1
    for int in $@; do
        ((result *= int))
    done
    echo ${result}
}

# Usage: sum int1 int2 ...
function sum () {
    local result=0
    for int in $@; do
        ((result += int))
    done
    echo ${result}
}


# Usage: progressBar "message" currentStep totalSteps
function progressBar() {
    local   bar='████████████████████'
    local space='                    '
    local wheel=('\' '|' '/' '-')

    local msg="${1}"
    local current=${2}
    local total=${3}
    local wheelIndex=$((current % 4))
    local position=$((100 * current / total))
    local barPosition=$((position / 5))

    echo -ne "\r|${bar:0:$barPosition}${space:$barPosition:20}| ${wheel[wheelIndex]} ${position}% [ ${msg} ] "
}

# Usage: versionCompare "1.2.3" "1.1.7"
function versionCompare () {
    function subVersion () {
        temp=${1%%"."*} && indexOf=$(echo ${1%%"."*} | echo ${#temp})
        echo -e "${1:0:indexOf}"
    }
    function cutDot () {
        local offset=${#1}
        local length=${#2}
        echo -e "${2:((++offset)):length}"
    }
    if [ -z "${1}" ] || [ -z "${2}" ]; then
        echo "=" && exit 0
    fi
    local v1=$(echo -e "${1}" | tr -d '[[:space:]]')
    local v2=$(echo -e "${2}" | tr -d '[[:space:]]')
    local v1Sub=$(subVersion $v1)
    local v2Sub=$(subVersion $v2)
    if (( v1Sub > v2Sub )); then
        echo ">"
    elif (( v1Sub < v2Sub )); then
        echo "<"
    else
        versionCompare $(cutDot $v1Sub $v1) $(cutDot $v2Sub $v2)
    fi
}

# Usage: formatSeconds 70 -> 1m 10s
# Credit: https://unix.stackexchange.com/a/27014
function formatSeconds {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    local result=""

    (( $D > 0 )) && result="${D}d "
    (( $H > 0 )) && result="${result}${H}h "
    (( $M > 0 )) && result="${result}${M}m "
    (( $S > 0 )) && result="${result}${S}s "
    echo -e "${result}" | sed -e 's/[[:space:]]*$//'
}
