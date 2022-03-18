#!/bin/bash
#Author: Jacques vanel
#Date : Mars, 9 2022
#let's find out if an otem or drectory exist


echo -e "Please enter the file or directory you are looking for: "
read FileorDir

if [ -f $FileorDir ]
 then
 echo " The file $FileorDir exist in this machine. "
  sleep 2
 echo "Here is the path to this file: "
  find / -name $FileorDir
elif [ -d $FileorDir ]
then
echo " The directory $FileorDir exist in this machine. "
sleep 2
echo "Here is the path to this file: "
find / -name $FileorDir
else
 echo
echo "Sorry but $FileorDir does not exiat :("

fi
