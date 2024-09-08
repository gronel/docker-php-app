#!/bin/sh

cd /var/www/html

FILE=/tmp/composer.ran
if [ -f $FILE ]; then
    echo "chowning /var/www/html/storage/ for www-data"
    chown -R www-data:www-data /var/www/html/storage/
else
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
    echo "chowning /var/www/html/storage/ for www-data"
    chown -R www-data:www-data /var/www/html/storage/
    touch $FILE
fi

mkdir /var/run/php
/usr/sbin/apachectl start
bash