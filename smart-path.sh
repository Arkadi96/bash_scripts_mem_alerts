#!/bin/bash

#input from termina
var=$1
if [ -z "$var" ]; then
     echo "Please set path"
     read var
fi

#checking validity
if [ -d "$var" ]
then
    echo "Directory is valid." 
else
    echo "Error: Directory does not exist."
fi

#checking for matchings in $PATH
patharray=$(echo $PATH | tr ":" "\n")

declare -i count=0

for element in $patharray
do
        if [ $var = $element ]; then
                count=$((count+1))
        fi
done

#if no matching add a new PATH and save on .bashrc
if [ $count = 0 ]; then
        echo "PATH=$var:$PATH" > temp.txt
	export PATH="$var:$PATH"
	if  cat ~/.bashrc | grep -q PATH ; then
		sed -i.bak '/^PATH=/d' ~/.bashrc
		var1=$?		
		if [ $var1 = 0 ]; then 
			echo "PATH in .bashrc has Updated"
		else
			echo "an Error has occured when updating PATH in .bashrc"
		fi
	else
		echo "new PATH has created in .bashrc"
	fi
	cat temp.txt >> ~/.bashrc
	rm temp.txt
else
        echo "WARNING! path already exists in PATH"
fi


