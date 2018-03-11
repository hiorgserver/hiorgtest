#!/bin/bash

# Start the MySQL daemon in the background.
service mysql start

until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

# start user-provided command
exec "$@"