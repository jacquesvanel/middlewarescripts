#!/bin/bash

       #Author : Jacques Vanel Siewe Mbouwe
       #Date : 24-Feb-2022

   ## ---------- script that provides steps to installing and configuring SonarQube on Centos 7 -----------------
 whoami
if [ $? = root ]
 then
 echo " Please log in as a regular before starting sonar.sh"
else
 exit 1
fi

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

if [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = ubuntu ] || [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = centos ]
  then

  sudo yum install wget unzip net-tools -y
  sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899zip   
  sudo unzip /opt/sonarqube-9.3.0.51899.zip
  sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
  cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
 clear

  elif [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = debian ]
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


if [ $? -ne 0 ]
then
 echo "the file sonar could not start :("
 sleep 3
 echo "Let's make sure the firwall is enabled and port 9000 is open!"
 sleep 3
  if [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = ubuntu ] || [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = centos ]
     then

     sudo yum install firewalld
      sudo yum install systemd
      sudo yum install systemctl
      systemctl start firewalld
      systemctl enable firewalld
      sudo firewall-cmd --permanent --add-port=9000/tcp
      sudo firewall-cmd --reload
      echo " SonarQube successfully started and configured. You may now connect to the SonarQube server through the this link: "
      echo "http://`hostname -I`:9000"

   
 
     elif [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = debian ]
       then

       sudo apt install firewalld
       sudo apt install systemd
       sudo apt install systemctl
       systemctl start firewalld
       systemctl enable firewalld
       sudo firewall-cmd --permanent --add-port=9000/tcp
       sudo firewall-cmd --reload
       echo " SonarQube successfully started and configured. You may now connect to the SonarQube server through the this link: "
       echo "http://`hostname -I`:9000"

     else [ cat /etc/os-release | grep ^ID= | awk -F "=" '{print $2}' = alpine ]
      then

      sudo apk install firewalld
      sudo apk install systemd
      sudo apk install systemctl
      systemctl start firewalld
      systemctl enable firewalld
      sudo firewall-cmd --permanent --add-port=9000/tcp
      sudo firewall-cmd --reload
      echo " SonarQube successfully started and configured. You may now connect to the SonarQube server through the this link: "
      echo "http://`hostname -I`:9000"
  fi
  else
  echo " SonarQube successfully started and configured. You may now connect to the SonarQube server through the this link: "
  echo "http://`hostname -I`:9000"
fi
