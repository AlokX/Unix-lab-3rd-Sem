
# <----------QUESTION----------->
# Write a program to print all the prime numbers from 1 to 300.
# Use nested loops, break & continue.
# <----------QUESTION----------->

#!/bin/bash
for i in {2..300} # for each number 
do
    flag=0
    for (( j=2; j<= $(( i/2 )); j++ ))
    do
        if [ $((i%j)) == 0 ]; then
            flag=1
            break
        fi
    done
    if [ $flag -eq 1 ]; then
        continue
    fi
    echo -n "$i "
done
echo
