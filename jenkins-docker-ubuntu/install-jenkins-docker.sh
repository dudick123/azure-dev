#!/bin/bash

logger "Updating Packages"
apt-get -y update

logger "Installing Jenkins"
sudo wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update && sudo apt-get install jenkins -y
sudo touch /var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion

logger "Installing Docker"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce

logger "Adding Users"
sudo usermod -aG docker azureuser
sudo usermod -aG docker jenkins

logger "Restarting Jenkins"
sudo service jenkins restart
