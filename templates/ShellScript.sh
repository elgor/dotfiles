#!/bin/bash

# variables, calculations, and arrays (no spaces around =)
X=3
CALC_VAL=$((5 * $X / 2))	# = 7
ARRAY=("one" $X 1 2)		# strings, variables, integer


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

# finish with "exit <number>"
exit 0
