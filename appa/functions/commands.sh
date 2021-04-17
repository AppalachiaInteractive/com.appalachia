#!/bin/bash

get_subcommand_directories()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }
    
    out=(`find "$APPA_COMMAND_HOME" -mindepth 1 -maxdepth 1 -type d`)
    
    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "[${FUNCNAME[0]}] [RETURN] $outi"
        done
    fi
    
    eval "$1=("${out[@]}")"
}
get_subcommands()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }  
    [ $2 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a command family path."; exit 2; }  

    out=(`find "$2" -maxdepth 1 -type f -name '*.sh'`)
    
    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "[${FUNCNAME[0]}] [RETURN] $outi"
        done
    fi
    eval "$1=("${out[@]}")"
}
get_commands()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; } 

    out=(`find "$APPA_COMMAND_HOME" -maxdepth 1 -type f -name '*.sh'`)

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "[${FUNCNAME[0]}] [RETURN] $outi"
        done
    fi
        
    eval "$1=("${out[@]}")"
}
get_command_families()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; } 

    out=(`find "$APPA_COMMAND_HOME" -mindepth 1 -maxdepth 1 -type d`)

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for outi in ${out[@]}
        do
            echo "[${FUNCNAME[0]}] [RETURN] $outi"
        done
    fi
        
    eval "$1=("${out[@]}")"
}
clean_subcommand()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }    
    [ $2 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply an argument to clean."; exit 2; }  
    [ $3 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a path to strip from the path."; exit 3; }  

    out=`echo $2 | sed 's/\.sh//g' | sed "s|$3/||g"`
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [RETURN] $out"; fi
    eval $1='$out'
}
clean_command()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }    
    [ $2 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply an argument to clean."; exit 2; }  

    out=`echo $2 | sed 's/\.sh//g' | sed "s|$APPA_COMMAND_HOME/||g"`
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [RETURN] $out"; fi
    eval $1='$out'
}
print_commands()
{
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    get_commands commands
    get_command_families command_families

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for command_file in ${commands[@]}
        do
            echo "[${FUNCNAME[0]}] [FILE]  " $command_file
        done
    fi

    if [ "$APPA_DEBUG" == "1" ] ; then 
        for command_family in ${command_families[@]}
        do
            echo "[${FUNCNAME[0]}] [FILE]  " $command_family
        done
    fi

    for command_file in ${commands[@]}
    do
        if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [ITER-S] $command_file"; fi

        clean_command printable_command_name $command_file
        echo ">  appa $printable_command_name"

        if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [ITER-E] $command_file"; fi
    done

    for command_family in ${command_families[@]}
    do
        if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [ITER-S] $command_family"; fi

        clean_command printable_command_family $command_family
        echo ">  appa $printable_command_family"
        
        get_subcommands subcommands $command_family

        for subcommand in ${subcommands[@]}
        do        
            if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] >[ITER-S] $subcommand"; fi 

            clean_subcommand printable_subcommand $subcommand $command_family
            echo ">  appa $printable_command_family $printable_subcommand"

            if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] >[ITER-E] $subcommand"; fi     
        done
        if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [ITER-E] $command_family"; fi
    done
    echo ''
}

process_commands()
{    
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]"; fi
    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [$# args] | "'$@'": [$@]"; fi
    
    # $#=1 $1    $#=2  $1  $2    $#=3  $1 $2  $3...
    # appa do   appa do run    appa do run args

    target_command=$1
    shift; if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [SHIFT] [$# args] | "'$@'": [$@]"; fi
    # $#=0 x     $#=1  x   $1    $#=2  x  $1  $2...
    # appa do   appa do run    appa do run args

    f="$APPA_COMMAND_HOME/$target_command"
    if [ -f "$f" ] ; then
        if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [COMMAND] $target_command"; fi
        
        $f "$@"
    fi
    
    f="$APPA_COMMAND_HOME/$target_command"
    if [ -d "$f" ] ; then

        if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [FAMILY] $target_command"; fi
 
        clean_command command_family $f 

        if [ $# -eq 0 ] ; then
        # $#=0 x  
        # appa do

            # ai/cmd/do/do.sh exists - run just this script
            if [ -f "$f/$command_family.sh" ] ; then
                if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [PATH] ai/cmd/do/do.sh - run all scripts in do folder"; fi
                if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}] [FAMILY] $f [COMMAND] $command_family.sh"; fi
                "$f/$command_family.sh"
                return $?

            else # ai/cmd/do/*.sh - run all scripts in do folder
                get_subcommands subcommands $f
                for subcommand in "${subcommands[@]}"
                do
                    if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [PATH] ai/cmd/do/*.sh - run all scripts in do folder"; fi
                    if [ $APPA_DEBUG -eq 1 ] ; then echo "[${FUNCNAME[0]}] [FAMILY] $f [SUBCOMMAND] $subcommand"; fi
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
            if [ -f "$f/$1.sh" ] ; then
                if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [PATH] "'[ $# -gt 0 ] ai/cmd/do/run.sh exists'; fi
                script=$1
                shift; if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [SHIFT] [$# args] | "'$@'": [$@]"; fi
                #            $#=0  x  x      $#=1  x  x   $1...
                #            appa do run    appa do run args
                "$f/$script.sh" "$@"
                return $?

            # ai/cmd/do/do.sh exists - run just this script
            elif [ -f "$f/$command_family.sh" ] ; then

                if [ "$APPA_DEBUG" == "1" ] ; then echo "[${FUNCNAME[0]}]: [PATH] "'[ $# -gt 0 ] ai/cmd/do/do.sh exists'; fi

                "$f/$command_family.sh" "$@"
                return $?
            fi
        fi
    fi    

    print_commands
    exit 1    
}