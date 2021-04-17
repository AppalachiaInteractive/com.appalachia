shopt -s nullglob

DEBUG=0
opwd=$(pwd)
AI_SCRIPT_HOME="${0%/*}"
AI_HOME=$(cd $AI_SCRIPT_HOME; cd ..; pwd; cd "$opwd")
AI_COMMAND_HOME="$AI_SCRIPT_HOME/cmd"
AI_PACKAGE_HOME="$AI_SCRIPT_HOME/package"
AI_SERVERS_HOME="$AI_SCRIPT_HOME/servers"

if [ -d "./.venv" ] ; then
    source ./.venv/Scripts/activate
else    
    source $AI_HOME/.venv/Scripts/activate
fi

python -m pip check -q

for x in "$AI_HOME/node_modules/.bin"; do
  case ":$PATH:" in
    *":$x:"*) :;; # already there
    *) PATH="$x:$PATH";;
  esac
done


if [ $? -ne 0 ]; then    
    if [ -d "./.venv" ] ; then
        if [ -f "requirements.txt"] ; then
            python -m pip install requirements.txt 
        else 
            python -m pip freeze > requirements.txt
        fi
    else        
        if [ -f "$AI_HOME/requirements.txt"] ; then
            python -m pip install  $AI_HOME/requirements.txt 
        else 
            python -m pip freeze > $AI_HOME/requirements.txt
        fi
    fi
fi

export AI_SCRIPT_HOME; export AI_HOME; export AI_COMMAND_HOME; export AI_PACKAGE_HOME; export AI_SERVERS_HOME

print_border()
{
    echo '________________________________________________________________________________'
}
print_header()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
   
    figlet 'APPALACHIA' -f '3D-ASCII'
    figlet 'INTERACTIVE' -f '3D-ASCII'
    echo ''
}
get_subcommand_directories()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }
    
    out=(`find "$AI_COMMAND_HOME" -mindepth 1 -maxdepth 1 -type d`)
    
    for outi in ${out[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [RETURN] $outi"; fi
    done
    eval "$1=("${out[@]}")"
}
get_subcommands()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }  
    [ $2 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a command family path."; exit 2; }  

    out=(`find "$2" -maxdepth 1 -type f -name '*.sh'`)
    
    for outi in ${out[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [RETURN] $outi"; fi
    done
    eval "$1=("${out[@]}")"
}
get_commands()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; } 

    out=(`find "$AI_COMMAND_HOME" -maxdepth 1 -type f -name '*.sh'`)

    for outi in ${out[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [RETURN] $outi"; fi
    done
        
    eval "$1=("${out[@]}")"
}
get_command_families()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; } 

    out=(`find "$AI_COMMAND_HOME" -mindepth 1 -maxdepth 1 -type d`)

    for outi in ${out[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [RETURN] $outi"; fi
    done
        
    eval "$1=("${out[@]}")"
}
clean_subcommand()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }    
    [ $2 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply an argument to clean."; exit 2; }  
    [ $3 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a path to strip from the path."; exit 3; }  

    out=`echo $2 | sed 's/\.sh//g' | sed "s|$3/||g"`
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [RETURN] $out"; fi
    eval $1='$out'
}
clean_command()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    [ $1 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply a return value."; exit 1; }    
    [ $2 ] || { echo "[${FUNCNAME[0]}] Incorrect usage; Must supply an argument to clean."; exit 2; }  

    out=`echo $2 | sed 's/\.sh//g' | sed "s|$AI_COMMAND_HOME/||g"`
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [RETURN] $out"; fi
    eval $1='$out'
}
print_commands()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi
    get_commands commands
    get_command_families command_families

    for command_file in ${commands[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [FILE]  " $command_file; fi
    done

    for command_family in ${command_families[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [FILE]  " $command_family; fi
    done

    for command_file in ${commands[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [ITER-S] $command_file"; fi

        clean_command printable_command_name $command_file
        echo ">  ai.sh $printable_command_name"

        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [ITER-E] $command_file"; fi
    done

    for command_family in ${command_families[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [ITER-S] $command_family"; fi

        clean_command printable_command_family $command_family
        echo ">  ai.sh $printable_command_family"
        
        get_subcommands subcommands $command_family

        for subcommand in ${subcommands[@]}
        do        
            if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] >[ITER-S] $subcommand"; fi 

            clean_subcommand printable_subcommand $subcommand $command_family
            echo ">  ai.sh $printable_command_family $printable_subcommand"

            if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] >[ITER-E] $subcommand"; fi     
        done
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [ITER-E] $command_family"; fi
    done
    echo ''
}
process_commands()
{
    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}]"; fi

    get_commands commands
    get_command_families command_families

    target_command=$1

    for f in ${commands[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [COMMAND] $f"; fi
        clean_command cmd $f 
        if [ "$target_command" == "$cmd" ]; then            
            if [ "$#" -ne 1 ]; then
                shift
                $f "$@"
                return $?
            else
                $f
                return $?
            fi
        fi
    done
    
    for f in ${command_families[@]}
    do
        if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [FAMILY] $f"; fi
        
        clean_command command_family $f 

        if [ "$target_command" == "$command_family" ]; then     

            if [ "$#" -eq 1 ]; then

                get_subcommands subcommands $f
                for subcommand in ${subcommands[@]}
                do
                    if [ $DEBUG -eq 1 ]; then echo "[${FUNCNAME[0]}] [FAMILY] $f [SUBCOMMAND] $subcommand"; fi
                    $subcommand
                    if [ $? -ne 0 ]; then
                        exit $?
                    fi
                done
                return $?

            else  
                shift
                script=$1
                shift
                $f/$script.sh "$@"
                return $?
                
            fi
        fi
    done

    print_commands
    exit 1    
}

commands=($AI_COMMAND_HOME/*)

if [ "$#" -eq 0 ]; then
    print_header
    print_commands 
else
    process_commands "$@"
fi
