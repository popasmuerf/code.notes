[source](https://superuser.com/questions/1837653/how-can-i-reset-my-mysql-root-password-in-mysql-8-0-36-on-red-hat-8-if-mysqld-s)



sudo service mysqld stop;
sudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables --skip-networking";
sudo service mysqld start;

mysql -u root;


FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '[password]';
FLUSH PRIVILEGES;
exit;

sudo service mysqld stop;
sudo systemctl unset-environment MYSQLD_OPTS;
sudo service mysqld start;


mysql -u root -p


ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '[password]';