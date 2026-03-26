FROM php:7.4-apache

# Install system dependencies for PHPSpreadsheet and MySQL support
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
 && docker-php-ext-install pdo_mysql zip \
 && a2enmod rewrite \
 && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy application files
COPY . /var/www/html
WORKDIR /var/www/html

# Ensure permissions for Apache/PHP
RUN chown -R www-data:www-data /var/www/html

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

EXPOSE 80
CMD ["apache2-foreground"]
