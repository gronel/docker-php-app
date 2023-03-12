FROM ubuntu:18.04
RUN apt-get update && apt-get install -y tzdata apt-utils
RUN apt-get install -y supervisor
RUN apt-get install -y software-properties-common libterm-readline-gnu-perl curl
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh
RUN add-apt-repository ppa:ondrej/php
RUN add-apt-repository ppa:ondrej/apache2
RUN apt-get update && \
    apt-get install -y nodejs php8.2 php8.2-fpm php8.2-mbstring php8.2-mysqli php8.2-bcmath php8.2-gmp php8.2-soap \
    mariadb-client git unzip php8.2-xml apache2 libapache2-mod-php8.2 php8.2-curl net-tools dos2unix php8.2-xdebug php8.2-zip php8.2-ldap

COPY docker-entrypoint.sh /root/
RUN dos2unix /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

COPY composer.sh /root/
RUN dos2unix /root/composer.sh

COPY npm.sh /root/
RUN dos2unix /root/npm.sh
RUN chmod +x /root/npm.sh

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod lbmethod_byrequests
RUN a2enmod headers

CMD ["/root/docker-entrypoint.sh"]
