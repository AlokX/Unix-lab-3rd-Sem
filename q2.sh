# <----------QUESTION----------->
# Write a program to generate all combinations of 1,2 and 3 using for loops.
# <----------QUESTION----------->

#!/bin/bash
for i in 1 2 3 
do
    for j in 1 2 3 
    do
        for k in 1 2 3 
        do
            echo -n "$i$j$k "
        done
    done
done
echo

