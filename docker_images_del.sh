#!/bin/bash
#Author: Jacques Vanel
#Date: March 20, 2022


echo "Hello, here is the list of docker containers in this computer: "
echo
echo
docker images -q
sleep 10

echo -e "Are you sure you want to delete them all? [yes/no]"
read answer

if [ $answer = yes ]
then

docker rm $(docker images -q)
elif [ $answer = no ]
then
exit 1
fi


