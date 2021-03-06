#!/bin/bash

# Start the MySQL daemon in the background.
service mysql start

# Wait until the server is up
until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

# Create database and user
mysql -e "CREATE DATABASE hiorgtest;"
mysql -e "GRANT ALL PRIVILEGES ON hiorgtest.* TO 'hiorgserver'@'%' IDENTIFIED BY 'hiorgserver';FLUSH PRIVILEGES;"

# Disable strict mode
echo "[mysqld]"  >> /etc/mysql/my.cnf
echo "" >> /etc/mysql/my.cnf
echo "sql_mode=NO_ENGINE_SUBSTITUTION" >> /etc/mysql/my.cnf

# Tell the MySQL daemon to shutdown again
service mysql stop
