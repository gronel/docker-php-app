FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y tzdata apt-utils ca-certificates
RUN apt-get install -y software-properties-common libterm-readline-gnu-perl curl gnupg
# Install Node.js from Ubuntu repository (simpler and more reliable)
RUN apt-get install -y nodejs npm
RUN add-apt-repository ppa:ondrej/php -y
RUN add-apt-repository ppa:ondrej/apache2 -y
RUN apt-get update

# Install basic tools (Node.js already installed above)
RUN apt-get install -y git unzip net-tools dos2unix locales supervisor clang

# Install Apache
RUN apt-get install -y apache2

# Install PHP 8.2 and core extensions (try with verbose output)
RUN apt-get install -y php8.2 libapache2-mod-php8.2

# Install PHP extensions in batches
RUN apt-get install -y \
    php8.2-mbstring \
    php8.2-mysqli \
    php8.2-bcmath \
    php8.2-gmp \
    php8.2-xml \
    php8.2-dev \
    php8.2-gd

RUN apt-get install -y \
    php8.2-curl \
    php8.2-zip \
    php8.2-ldap \
    php8.2-soap

# Install MariaDB client and xdebug separately as they might have dependency issues
RUN apt-get install -y mariadb-client
RUN apt-get install -y php8.2-xdebug

    # Add Microsoft ODBC repository and install the driver with better error handling
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL --retry 3 --retry-delay 5 --insecure https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    curl --retry 3 --retry-delay 5 --insecure https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" >> /etc/apt/sources.list.d/mssql-release.list && \
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
