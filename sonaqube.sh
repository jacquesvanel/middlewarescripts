#!/bin/bash

       #Author : Jacques Vanel Siewe Mbouwe
       #Date : 24-Feb-2022

   ## ---------- script that provides steps to installing and configuring SonarQube on Centos 7 -----------------           
os=`cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}'`

 echo "Run this script to install SonarQube on your Centos server. Please note that SonarQube does not work when you start it as a root user."
sleep 3

 echo " Installation in progress..."
 echo
 echo "This might take a while..."
  sleep 3
  clear
 echo "First let's do an update of the system"
  sleep 3
  sudo yum update -y
  clear
 echo "\n Update is done!! \n"
  sleep 3
 echo "Now let's install java and all the tools neccessary for this application"
  sleep 3
 sudo yum install java-11-openjdk-devel java-11-openjdk -y
 clear

if [ $os = ubuntu ] || [ $os = centos ]
  then

  sudo yum install wget unzip net-tools -y
  sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899zip   
  sudo unzip /opt/sonarqube-9.3.0.51899.zip
  sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
  cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
 clear

  elif [ $os = debian ]
  then

 sudo apt install wget unzip net-tools -y
  sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899zip   
  sudo unzip /opt/sonarqube-9.3.0.51899.zip
  sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
  cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
 clear

  else

   sudo apk install wget unzip net-tools -y
  sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899zip   
  sudo unzip /opt/sonarqube-9.3.0.51899.zip
  sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
  cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
 clear

fi


 echo " System starting SonarQube..."
 sleep 5
 ./sonar.sh start

user=`cat /etc/passwd | awk -F ":" '{print $1}' | grep root`
if [ $user = root ]
then
echo " Please log in as a regular before starting sonar.sh"
exit 1

if [ $? = 0 ]
 echo "the file sonar could not start :("
 sleep 2
 echo "Let's make sure the firwall is enabled and port 9000 is open!"
 sleep 3
 sudo yum install firewalld
 systemctl start firewalld
 systemctl enable firewalld
 sudo firewall-cmd --permanent --add-port=9000/tcp
 sudo firewall-cmd --reload
 clear

 elif [ $os = ubuntu ] || [ $os = centos ]
 then

 sudo yum install firewalld
 systemctl start firewalld
 systemctl enable firewalld
 sudo firewall-cmd --permanent --add-port=9000/tcp
 sudo firewall-cmd --reload

 elif [ $os = debian ]
 then

  sudo yum install firewalld
  systemctl start firewalld
  systemctl enable firewalld
  sudo firewall-cmd --permanent --add-port=9000/tcp
  sudo firewall-cmd --reload

  elif [ $os = alpine ]
  then

  sudo yum install firewalld
  systemctl start firewalld
  systemctl enable firewalld
  sudo firewall-cmd --permanent --add-port=9000/tcp
  sudo firewall-cmd --reload

  else
  echo " SonarQube successfully started and configured. You may now connect to the SonarQube server through the this link: "
  echo "http://`hostname -I`:9000"
fi

