#!/bin/bash



                               #This is the script for docker installation
                               #Author: Jacques Vanel
                               #This is for a linux CENTOS 7 version and Ubuntu


                               #First let's make sure we remove any kind of docker version installed in the machine



echo "Beginning the installation of Docker on your CentOS system..."
sleep 3
echo
echo " Removing all older versions of docker. Please wait..."
sleep 3
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
clear
echo "Now let's setup the docker repository"
sleep 4

sudo yum install yum-utils -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
clear

echo "Installation of the docker engine..."
sleep 4

sudo yum install docker-ce docker-ce-cli containerd.io -y
clear

#Check the docker status and enable the daemon
sudo yum install systemd -y
sudo systemctl start docker
sudo systemctl enable docker
clear

echo "Here is the status of Docker:"
echo
echo
sudo systemctl status docker
sleep 10
clear
