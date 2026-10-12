#!/bin/bash
set -e

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

mysqld_safe --datadir=/var/lib/mysql &

for i in $(seq 1 30); do
    if mysqladmin ping --silent; then
        break
    fi
    sleep 1
done

exec apachectl -D FOREGROUND
