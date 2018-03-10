#!/bin/bash

service mysql start

until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

mysql -e "CREATE DATABASE hiorgtest;"
mysql -e "GRANT ALL PRIVILEGES ON hiorgtest.* TO 'hiorgserver'@'%' IDENTIFIED BY 'hiorgserver';FLUSH PRIVILEGES;"
