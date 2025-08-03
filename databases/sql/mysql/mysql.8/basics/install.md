# username: ec2-user
# 52.15.154.163

sudo yum update -y
sudo amazon-linux-extras install epel -y 
sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql80-community-release-el7-5.noarch.rpm
sudo yum install mysql-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld



sudo mysql_secure_installation


mysql -u root -p


SELECT VERSION();


CREATE DATABASE test_db;