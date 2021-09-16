#!bin/bash
var="$1"
if [ ! -z "$var" ]; then
       	threshold=$var
else
	echo "Please set the threshold for memory usage"
	read threshold
fi
memusage=$(free | grep Mem | awk '/Mem/ {printf("%.u"), $3/$2*100}')
echo "#########################"
echo "######Memory usage#######"
if [ "$memusage" -ge $threshold ]; then
	echo "Alert: current memory usage is $memusage%"
else
	echo "Memory usage is in under controll"
fi
#-----------------------------------------------------------------------
echo "##########################"
echo "###TOP 10 biggest files###"
sudo du /home | sort -k 1nr | awk '{print $1,$2}' > tempfile;  head -n 10 tempfile;
echo $filelist
rm tempfile;
#----------------------------------------------------------------------
echo "##########################"
echo "###TOP 10 mem use procs###"
ps -o %mem,command ax | sort -k 1nr | head -n 10
#----------------------------------------------------------------------

