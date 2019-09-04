#!/bin/bash
echo "i am before_install.sh"
# Install libaries
whoami
pwd
apt-get upgrade 
apt-get install -y python3-pip build-essential libssl-dev libffi-dev python3-dev python3-venv
echo "packages installed successfully"
[ -d /tutorialmyprojectdir ] || mkdir /tutorialmyprojectdir
cd /tutorialmyprojectdir
virtualenv -p python3 venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --no-input

# Set permission for all files
#sudo chown -R www-data:www-data /var/www/

# Restart services
service apache2 restart
