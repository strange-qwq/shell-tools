wget https://repo.mysql.com//mysql80-community-release-el8-1.noarch.rpm
rpm -ivh mysql80-community-release-el8-1.noarch.rpm
yum install mysql-server
systemctl enable mysqld.service
systemctl start mysqld.service