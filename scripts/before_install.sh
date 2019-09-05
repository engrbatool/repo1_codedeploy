#!/bin/bash
echo "i am before_install.sh"
# Install libaries
whoami
pwd
apt-get upgrade 
apt-get install -y python3-pip build-essential libssl-dev libffi-dev python3-dev python3-venv apache2 mysql-server
echo "packages installed successfully"
[ -d /tutorialmyprojectdir ] || mkdir /tutorialmyprojectdir
cd /tutorialmyprojectdir

#virtualenv -p python3 venv
apt-get install python3-pip
echo "pip is installed+++++++++++++"
pip3 install virtualenv 
echo "virtual env is installed============"
