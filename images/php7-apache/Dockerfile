FROM ubuntu:18.04
RUN apt-get update && apt-get install -y tzdata apt-utils
RUN apt-get install -y supervisor
RUN apt-get install -y software-properties-common libterm-readline-gnu-perl curl
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh
RUN add-apt-repository ppa:ondrej/php
RUN add-apt-repository ppa:ondrej/apache2
RUN apt-get update && \
    apt-get install -y  ca-certificates nodejs php7.4 php7.4-fpm php7.4-mbstring php7.4-mysqli php7.4-bcmath php7.4-gmp php7.4-soap \
    mariadb-client git unzip php7.4-xml apache2 libapache2-mod-php7.4 php7.4-curl net-tools dos2unix php7.4-xdebug php7.4-zip php7.4-ldap

COPY docker-entrypoint.sh /root/
RUN dos2unix /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

COPY composer.sh /root/
RUN dos2unix /root/composer.sh
RUN chmod +x /root/composer.sh

COPY npm.sh /root/
RUN dos2unix /root/npm.sh
RUN chmod +x /root/npm.sh

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod lbmethod_byrequests
RUN a2enmod headers

CMD ["/root/docker-entrypoint.sh"]
