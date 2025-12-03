#!/bin/bash

# wait for MySQL
echo "Waiting for MySQL..."
until nc -z -v -w30 db 3306
do
  echo "Waiting for database connection..."
  sleep 3
done

echo "Database is ready! Running migrations..."

php artisan migrate --force || true

echo "Starting PHP-FPM..."
php-fpm
