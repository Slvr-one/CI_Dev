#!bin/bash
set -eu

sudo apt-get update
sudo apt-get install default-jre -y #Install Java

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
