#!/bin/bash
echo "i am after_install.sh"

DB_ROOT_USER="root"
DB_ROOT_PASSWORD="redhat2614"
DB_HOST="localhost"
DATABASE_Name= "aleemappdb"
DB_APP_USER="aleemapp_dbuser"
DB_APP_PASSWORD="password"
DB_SOCKET="/var/run/mysqld/mysqld.sock"

# Install libaries
whoami
pwd
service mysql start
service mysql status
ps -ef |grep mysql
echo "======mysql service started ===="
mysqladmin --user=root password $DB_ROOT_PASSWORD
echo "=======mysql root password created successfully======"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="DELETE FROM mysql.user WHERE User='';"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="select * from mysql.user;"
echo "======= Anonymous users deleted successfully ======="
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="select * from mysql.user;"
echo "======= Mysql Root user remote access disabled======"
     # - mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="DROP DATABASE test;"
     # - mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
     # - echo "======= Mysql test database deleted =========="
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="FLUSH PRIVILEGES;"
echo "===== Run FLUSH PRIVILEGES successfull"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="CREATE USER 'aleemapp_dbuser'@'localhost' IDENTIFIED BY 'password';"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="CREATE DATABASE aleemappdb;"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="GRANT ALL PRIVILEGES ON aleemappdb.* to 'aleemapp_dbuser'@'localhost'"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASSWORD  --execute="FLUSH PRIVILEGES;"
echo "===== App DB user Created Run FLUSH PRIVILEGES successfull"


cd /tutorialmyprojectdir

virtualenv -p python3 venv

source venv/bin/activate
pip3 install -r requirements.txt
/tutorialmyprojectdir/venv/bin/python  /tutorialmyprojectdir/src/manage.py makemigrations
/tutorialmyprojectdir/venv/bin/python  /tutorialmyprojectdir/src/manage.py migrate

mv  /etc/apache2/sites-enabled/django-apache.conf /etc/apache2/sites-enabled/000-default.conf
mv  /etc/apache2/sites-available/django-apache.conf /etc/apache2/sites-enabled/000-default.conf

systemctl stop apache2
systemctl start apache2
