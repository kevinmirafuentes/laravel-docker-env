# Dockerfile for Laravel app with PHP 8.4
FROM php:8.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY ./src /var/www

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www

RUN composer install --no-interaction --optimize-autoloader --ignore-platform-reqs

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
