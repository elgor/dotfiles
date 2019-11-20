#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Company: Open-Source
# Project: New Project
# Module:  myscript
# Author:  Emanuel Regnath (emanuel.regnath@tum.de)
# 
# Description: Represents the myscript.
# It is a driver/manager/handler/database for XXXX
# and is used by XXXX to XXXX
# 
# ToDo:
# [ ] Refactor
# [ ] Fix Bug:
# ------------------------------------------------------------------------------

# variables, calculations, and arrays (no spaces around =)
X=3
CALC_VAL=$((5 * $X / 2))	# = 7
ARRAY=("one" $X 1 2)		# strings, variables, integer

T_START=$(date +%s.%3N)    # time in sec with ms resolution


# arrays
echo ${ARRAY[@]}  # individual words for each element
echo ${ARRAY[*]}  # one word containing all elements
len=${#ARRAY[@]}
for i in "${!ARRAY[@]}"; do
	another_array+=(${ARRAY[$i]})   # add to array
done



# functions
function usage () {
	echo "Usage: $0 [OPTIONS] FILENAME"
	exit 1
} 


# process comand line arguments like a boss
while getopts hp:v opt 
do
   case "$opt" in
      h) usage;;
      p) path=$OPTARG;;
      v) verbose="yes";;
      \?) usage;;
   esac
done
	
# read file line by line
while read f
do
	echo "Line is $f" 
done < $path 

	
read -p "Do you want to continue? (y|n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # do dangerous stuff
fi

# tests
# Strings: ==, !=, \<, \>
# Integer: -eq, -ne, -lt, -gt, -le, -ge
# Files: -f, -d, -r, -w, -x 
if [ "$X" -ge "$CALC_VAL" ]; then 
	echo "Hello World"
fi	




# exit with error code
exit 0
