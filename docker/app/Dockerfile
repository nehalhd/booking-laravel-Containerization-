
#Stage 1: Composer Dependencies

FROM php:7.4-fpm AS composer_builder

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl

# Copy Composer from official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

COPY ./composer.json ./composer.lock ./

RUN composer install --no-dev --prefer-dist --no-interaction --no-scripts



#  Stage 2: Production PHP-FPM

FROM php:7.4-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    bash \
    autoconf \
    gcc \
    g++ \
    make \
    libc-dev \
    oniguruma-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    git \
    file \
    re2c

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip

# Copy optimized vendor from stage 1
COPY --from=composer_builder /app /var/www/html

# Set correct working directory
WORKDIR /var/www/html

# Fix permissions
RUN adduser -D -u 1000 laravel && \
    chown -R laravel:laravel /var/www/html

USER laravel

# Expose php-fpm port
EXPOSE 9000

CMD ["php-fpm"]
