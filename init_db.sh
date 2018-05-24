#!/bin/bash

# Start the MySQL daemon in the background.
service mysql start

# Wait until the server is up
until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

# Create hiorgtest database and user
mysql -e "CREATE DATABASE hiorgtest;"
mysql -e "GRANT ALL PRIVILEGES ON hiorgtest.* TO 'hiorgserver'@'%' IDENTIFIED BY 'hiorgserver';FLUSH PRIVILEGES;"

# Create hiorgserver database and user
mysql -e "CREATE DATABASE hiorgserver;"
mysql -e "GRANT ALL PRIVILEGES ON hiorgserver.* TO 'hiorgserver'@'%' IDENTIFIED BY 'hiorgserver';FLUSH PRIVILEGES;"

# Tell the MySQL daemon to shutdown again
service mysql stop
