#!/bin/sh

cd /var/www/html

FILE=/tmp/composer.ran
if [ -f $FILE ]; then
    echo "composer has already ran"
else
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
    echo "chowning /var/www/html/storage/ for www-data"
    chown -R www-data:www-data /var/www/html/storage/
    touch $FILE
fi

mkdir /var/run/php
## with cron
# /usr/sbin/cron && exec /usr/sbin/apache2ctl -DFOREGROUND
## no cron
exec /usr/sbin/apache2ctl -DFOREGROUND
