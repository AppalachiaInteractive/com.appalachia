#!/bin/bash


get_subcommand_directories()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    [ $1 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a return value.${C_RST}"; exit 1; }
    
    out=(`find "$APPA_COMMAND_HOME" -mindepth 1 -maxdepth 1 -type d`)
    
    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[RETURN]${C_RST} ${C_VAL}${outi}${C_RST}"
        done
    fi
    
    eval "$1=("${out[@]}")"
}
get_subcommands()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    [ $1 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a return value.${C_RST}"; exit 1; }  
    [ $2 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a command family path.${C_RST}"; exit 2; }  

    out=(`find "$2" -maxdepth 1 -type f -name '*.sh'`)
    
    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[RETURN]${C_RST} ${C_VAL}${outi}${C_RST}"
        done
    fi
    eval "$1=("${out[@]}")"
}
get_commands()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    [ $1 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a return value.${C_RST}"; exit 1; } 

    out=(`find "$APPA_COMMAND_HOME" -maxdepth 1 -type f -name '*.sh'`)

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[RETURN]${C_RST} ${C_VAL}${outi}${C_RST}"
        done
    fi
        
    eval "$1=("${out[@]}")"
}
get_command_families()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    [ $1 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a return value.${C_RST}"; exit 1; } 

    out=(`find "$APPA_COMMAND_HOME" -mindepth 1 -maxdepth 1 -type d`)

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[RETURN]${C_RST} ${C_VAL}${outi}${C_RST}"
        done
    fi
        
    eval "$1=("${out[@]}")"
}
clean_subcommand()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    [ $1 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a return value.${C_RST}"; exit 1; }    
    [ $2 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply an argument to clean.${C_RST}"; exit 2; }  
    [ $3 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a path to strip from the path.${C_RST}"; exit 3; }  

    out=`echo $2 | sed 's/\.sh//g' | sed "s|$3/||g"`
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[RETURN]${C_RST} ${C_VAL}${out}${C_RST}"; fi
    eval $1='$out'
}
clean_command()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    [ $1 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply a return value.${C_RST}"; exit 1; }    
    [ $2 ] || { echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_ERR}Incorrect usage; Must supply an argument to clean.${C_RST}"; exit 2; }  

    out=`echo $2 | sed 's/\.sh//g' | sed "s|$APPA_COMMAND_HOME/||g"`
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[RETURN] ${C_RST}${C_VAL}${out}${C_RST}"; fi
    eval $1='$out'
}
print_commands()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    get_commands commands
    get_command_families command_families

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for command_file in ${commands[@]}
        do
            echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[FILE]${C_RST} ${C_VAL}$command_file${C_RST}"
        done
    fi

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for command_family in ${command_families[@]}
        do
            echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[FILE]${C_RST} ${C_VAL}$command_family${C_RST}"
        done
    fi

    for command_file in ${commands[@]}
    do
        if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[ITER-S]${C_RST} ${C_VAL}$command_file${C_RST}"; fi

        clean_command printable_command_name $command_file
        echo "${C_CMD}>  appa $printable_command_name${C_RST}"

        if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[ITER-E]${C_RST} ${C_VAL}$command_file${C_RST}"; fi
    done

    for command_family in ${command_families[@]}
    do
        if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[ITER-S]${C_RST} ${C_VAL}$command_family${C_RST}"; fi

        clean_command printable_command_family $command_family
        echo "${C_CMDF}>  appa $printable_command_family${C_RST}"
        
        get_subcommands subcommands $command_family

        for subcommand in ${subcommands[@]}
        do        
            if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[ . ITER-S]${C_RST} ${C_VAL}$subcommand${C_RST}"; fi 

            clean_subcommand printable_subcommand $subcommand $command_family
            echo "${C_CMD}>  appa $printable_command_family $printable_subcommand${C_RST}"

            if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[ . ITER-E]${C_RST} ${C_VAL}$subcommand${C_RST}"; fi     
        done
        if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[ITER-E]${C_RST} ${C_VAL}$command_family${C_RST}"; fi
    done
    echo ''
}

process_commands()
{    
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNCS}[${FUNCNAME[0]}]${C_RST}"; fi
    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_ARGS}[$# args] | "'$@'": [$@]${C_RST}"; fi
    
    # $#=1 $1    $#=2  $1  $2    $#=3  $1 $2  $3...
    # appa do   appa do run    appa do run args

    target_command=$1
    shift; if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_NOTE}[SHIFT]${C_RST} ${C_ARGS}[$# args] | "'$@'": [$@]${C_RST}"; fi
    # $#=0 x     $#=1  x   $1    $#=2  x  $1  $2...
    # appa do   appa do run    appa do run args

    f="$APPA_COMMAND_HOME/$target_command.sh"
    if [ -f "$f" ] ; then
        if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[COMMAND]${C_RST} ${C_VAL}$target_command${C_RST}"; fi
        
        $f "$@"
        exit $?
    fi
    
    d="$APPA_COMMAND_HOME/$target_command"
    if [ -d "$d" ] ; then

        if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[FAMILY]${C_RST} ${C_VAL}$target_command${C_RST}"; fi
 
        clean_command command_family $d 

        if [ $# -eq 0 ] ; then
        # $#=0 x  
        # appa do

            # ai/cmd/do/do.sh exists - run just this script
            if [ -f "$d/$command_family.sh" ] ; then
                if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_NOTE}[PATH]${C_RST} ${C_VAL}ai/cmd/do/do.sh - run all scripts in do folder${C_RST}"; fi
                if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[FAMILY]${C_RST} $d ${C_NOTE}[COMMAND]${C_RST} ${C_VAL}$command_family.sh${C_RST}"; fi
                "$d/$command_family.sh"
                return $?

            else # ai/cmd/do/*.sh - run all scripts in do folder
                get_subcommands subcommands $d
                for subcommand in "${subcommands[@]}"
                do
                    if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_NOTE}[PATH]${C_RST} ${C_VAL}ai/cmd/do/*.sh - run all scripts in do folder${C_RST}"; fi
                    if [ $APPA_DEBUG -eq 1 ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST} ${C_NOTE}[FAMILY]${C_RST} $d ${C_NOTE}[SUBCOMMAND]${C_RST} ${C_VAL}$subcommand${C_RST}T"; fi
                    "$subcommand"
                    if [ $? -ne 0 ] ; then
                        exit $?
                    fi
                done
                exit 0
            fi           
        else #[ $# -gt 0 ] ; then
        #            $#=1  x   $1    $#=2  x  $1  $2...
        #            appa do run    appa do run args

            # ai/cmd/do/run.sh exists
            if [ -f "$d/$1.sh" ] ; then
                if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_NOTE}[PATH]${C_RST} ${C_VAL}"'[ $# -gt 0 ] '"ai/cmd/do/run.sh exists${C_RST}"; fi
                script=$1
                shift; if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_NOTE}[SHIFT]${C_RST} ${C_ARGS}[$# args] | "'$@'": [$@]"; fi
                #            $#=0  x  x      $#=1  x  x   $1...
                #            appa do run    appa do run args
                "$d/$script.sh" "$@"
                return $?

            # ai/cmd/do/do.sh exists - run just this script
            elif [ -f "$d/$command_family.sh" ] ; then

                if [ "$APPA_DEBUG" == "1" ] ; then echo "${C_FUNC}[${FUNCNAME[0]}]${C_RST}: ${C_NOTE}[PATH]${C_RST} "${C_VAL}'[ $# -gt 0 ] '"ai/cmd/do/do.sh exists${C_RST}"; fi

                "$d/$command_family.sh" "$@"
                return $?
            fi
        fi
    fi    

    print_commands
    exit 1    
}