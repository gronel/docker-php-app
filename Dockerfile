FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    libicu-dev \
    libxml2-dev \
    default-mysql-client

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Allow plugins for Composer in non-interactive mode
# RUN composer config --global allow-plugins true

# Copy existing application directory contents
# COPY . /var/www

# Set working directory
WORKDIR /var/www

# Install Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Run Composer install
# RUN composer install

# Set permissions
RUN chown -R www-data:www-data /var/www

EXPOSE 9000
CMD ["php-fpm"]