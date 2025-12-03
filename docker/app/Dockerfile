
#Stage 1: Composer Dependencies

FROM php:7.4-fpm AS composer_builder

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl

# Copy Composer from official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY ./composer.json ./composer.lock ./

RUN composer install --no-dev --prefer-dist --no-interaction --no-scripts

COPY . .

#  Stage 2: Production PHP-FPM
FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    bash \
    netcat \
    libpng-dev \
    libjpeg62-turbo-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo pdo_mysql mbstring zip


# Copy optimized vendor from stage 1
COPY --from=composer_builder /app /var/www/html

# Set correct working directory
WORKDIR /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Add user laravel with UID 1000 and no password
RUN useradd -u 1000 -m laravel \
    && chown -R laravel:laravel /var/www/html

USER laravel
# Expose php-fpm port
EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
