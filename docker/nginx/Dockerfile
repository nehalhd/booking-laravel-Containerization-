FROM nginx:stable-alpine

# Remove default configs
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom optimized config
# COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy public files only
COPY . /var/www/html

# Permissions
RUN chmod -R 755 /var/www/html

EXPOSE 80
