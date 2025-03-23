FROM ubuntu:20.04
RUN apt-get update && apt-get install -y tzdata apt-utils ca-certificates
RUN apt-get install -y software-properties-common libterm-readline-gnu-perl curl
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    NODE_MAJOR=18 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list
RUN add-apt-repository ppa:ondrej/php
RUN add-apt-repository ppa:ondrej/apache2
RUN apt-get update && \
    apt-get install -y nodejs php8.2 php8.2-mbstring php8.2-mysqli php8.2-bcmath php8.2-gmp \
    mariadb-client git unzip php8.2-xml php8.2-dev apache2 libapache2-mod-php8.2 php8.2-curl net-tools dos2unix \
    php8.2-zip php8.2-ldap php8.2-xdebug php8.2-soap locales supervisor clang

    # Add Microsoft ODBC repository and install the driver
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/11/prod/ focal main" >> /etc/apt/sources.list.d/mssql-release.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF && \
    apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    unixodbc-dev \
    libgssapi-krb5-2 \
    libsybdb5 \
    && pecl install pdo_sqlsrv sqlsrv \
    && echo "extension=pdo_sqlsrv.so" > /etc/php/8.2/mods-available/pdo_sqlsrv.ini \
    && echo "extension=sqlsrv.so" > /etc/php/8.2/mods-available/sqlsrv.ini \
    && phpenmod pdo_sqlsrv sqlsrv

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

ENTRYPOINT ["/bin/sh", "-c", "if [ -f /root/docker-entrypoint.sh ]; then /root/docker-entrypoint.sh; else pwsh /root/docker-entrypoint.ps1; fi"]
