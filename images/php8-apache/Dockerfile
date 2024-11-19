FROM ubuntu:20.04
RUN apt-get update && apt-get install -y tzdata apt-utils
RUN apt-get install -y software-properties-common libterm-readline-gnu-perl curl
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    NODE_MAJOR=18 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list
RUN add-apt-repository ppa:ondrej/php
RUN add-apt-repository ppa:ondrej/apache2
RUN apt-get update && \
    apt-get install -y nodejs php7.2 php7.2-mbstring php7.2-mysqli php7.2-bcmath php7.2-gmp \
    mariadb-client git unzip php7.2-xml php7.2-dev apache2 libapache2-mod-php7.2 php7.2-curl net-tools dos2unix \
    php7.2-zip php7.2-ldap php7.2-xdebug php7.2-soap locales supervisor clang
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN ~/.cargo/bin/cargo install cargo-php --git https://github.com/davidcole1340/ext-php-rs.git?rev=8985cb2f82ac680083b74a5f377b2fda9c8f04d4
COPY docker-entrypoint.sh /root/
RUN dos2unix /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2ensite default-ssl


WORKDIR /var/www/html

ENTRYPOINT "/root/docker-entrypoint.sh"
