# <----------QUESTION----------->
# Write shell scripts which works similar to the following Unix commands, head,tail,more.
# Try to incorporate as many options as possible that are available with these Unix commands.
# <----------QUESTION----------->


# ===========
#    MORE   |
# ===========





# ===========
#    HEAD   |
# ===========

#!/bin/bash
usage()
{
  echo "Usage: $0 [OPTION]..[FILE]..."
  echo "Print the first 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.

Mandatory arguments to long options are mandatory for short options too.
-n,  [-]NUM  print the first NUM lines instead of the first 10;
       with the leading '-', print all but the last
       NUM lines of each file
-q,    never print headers giving file names
-v,    always print headers giving file names
-z,    line delimiter is NUL, not newline
-h,    display this help and exit"
}

while getopts 'n:?hvqz' c
do
    case $c in 
        n) limit=$OPTARG ;;
        v) verbose=true ;;
        q) verbose=false ;;
        z) nul_delim=true; IFS=$'' ;;
        h|?) usage ; exit 2 ;; esac
done
shift $((OPTIND-1))

[ $# -lt 1 ] && usage
[ -z $verbose ] && [ $# -ge 2 ] && verbose=true #defaulting to mentioning filename for multiple files unless otherwise specified
[ -z $limit ]  && limit=10 #setting default max line 
[ -z $nul_delim ] && IFS=$'\n' 

for file in "$@"
do
    [ ! -f $file ] && echo -e "\n==> $file <==\ncannot open '$file' for reading: No such file or directory" && continue

    [ "$verbose" = true ] && echo "==> $file <=="

    read -d '' -r -a lines < $file 
    line_no=${#lines[@]}
    
    [ $limit -gt $line_no ] && limit=$line_no #setting max line to end of file
    [ $limit -lt 0 ] && limit=$((line_no + limit)) #handles the minus "no of lines.",
    for (( i=0; $i < $limit; i++ ))
    do
        printf "%s\n" "${lines[$i]}"
    done
done







# ===========
#    TAIL   |
# ===========

#!/bin/bash
usage()
{
  echo "Usage: $0 [OPTION]... [FILE]...
Print the last 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.


Mandatory arguments to long options are mandatory for short options too.
  -n,   [+]NUM       output the last NUM lines, instead of the last 10;
                             or use -n +NUM to output starting with line NUM
  -q,   never output headers giving file names
  -v,   always output headers giving file names
  -z,   line delimiter is NUL, not newline
  -h,   display this help and exit"
  exit 2
}

while getopts 'n:?hvqz' c
do
    case $c in 
        n) limit=$OPTARG ;;
        v) verbose=true ;;
        q) verbose=false ;;
        z) nul_delim=true; IFS=$'' ;;
        h|?) usage ;; esac
done
shift $((OPTIND-1))

[ $# -lt 1 ] && usage
[ -z $verbose ] && [ $# -ge 2 ] && verbose=true #defaulting to mentioning filename for multiple files unless otherwise specified
[ -z $limit ]  && limit=10 #setting default start line
[ -z $nul_delim ] && IFS=$'\n' 

for file in "$@"
do
    [ ! -f $file ] && echo "cannot open '$file' for reading: No such file or directory" && continue
    
    [ "$verbose" = true ] && echo "==> $file <=="
    read -d '' -r -a lines < $file
    line_no=${#lines[@]}


    if [[ $limit == +* ]]; then 
        i=$((limit -1)) 
    else 
        i=$((line_no-limit)) #sets the lower limit
    fi
    [ $i -lt 0 ] && i=0 #handles minus line numbers 

    for (( ; $i <= $line_no; i++ ))
    do
        printf "%s\n" "${lines[$i]}"
    done

done