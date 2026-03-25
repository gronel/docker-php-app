FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y tzdata apt-utils ca-certificates
RUN apt-get install -y software-properties-common libterm-readline-gnu-perl curl
RUN add-apt-repository ppa:ondrej/php -y
RUN add-apt-repository ppa:ondrej/apache2 -y
RUN apt-get update

# Install basic tools
RUN apt-get install -y git unzip net-tools dos2unix locales supervisor clang

# Install NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# Install Apache
RUN apt-get install -y apache2

# Install PHP 8.3 and core extensions
RUN apt-get install -y php8.3 libapache2-mod-php8.3

# Install PHP extensions in batches
RUN apt-get install -y \
    php8.3-mbstring \
    php8.3-mysqli \
    php8.3-bcmath \
    php8.3-gmp \
    php8.3-xml \
    php8.3-dev \
    php8.3-gd

RUN apt-get install -y \
    php8.3-curl \
    php8.3-zip \
    php8.3-ldap \
    php8.3-soap

# Install MariaDB client and xdebug separately as they might have dependency issues
RUN apt-get install -y mariadb-client
RUN apt-get install -y php8.3-xdebug

# Install Microsoft ODBC Driver 18 for SQL Server (Ubuntu 22.04, ARM64/AMD64)
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg \
    && echo "deb [arch=amd64,arm64] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends msodbcsql18 unixodbc-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install PHP extensions for SQL Server using PECL
RUN apt-get update && apt-get install -y \
    php8.3-pdo \
    php8.3-mysql \
    && printf "\n" | pecl install sqlsrv \
    && printf "\n" | pecl install pdo_sqlsrv \
    && echo "extension=sqlsrv.so" > /etc/php/8.3/mods-available/sqlsrv.ini \
    && echo "extension=pdo_sqlsrv.so" > /etc/php/8.3/mods-available/pdo_sqlsrv.ini \
    && phpenmod sqlsrv pdo_sqlsrv \
    && rm -rf /tmp/pear /root/.pearrc

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY docker-entrypoint.sh /root/
RUN dos2unix /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2ensite default-ssl


WORKDIR /var/www/html

ENTRYPOINT ["/bin/sh", "-c", "if [ -f /root/docker-entrypoint.sh ]; then /root/docker-entrypoint.sh; else pwsh /root/docker-entrypoint.ps1; fi"]
