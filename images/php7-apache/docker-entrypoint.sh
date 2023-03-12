#!/bin/sh

cd /var/www/html

FILE=composer.phar
if [ find $FILE ]; then
    echo "composer has already ran"
else
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php

    echo "chowning /var/www/html/storage/ for www-data"
    chown -R www-data:www-data /var/www/html/storage/
    touch $FILE
fi

exec /usr/sbin/apache2ctl -DFOREGROUND