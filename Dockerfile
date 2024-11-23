FROM webdevops/php-nginx:8.3-alpine

# Install Xdebug
RUN apk add --update linux-headers \
    && apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del $PHPIZE_DEPS

# Copy Xdebug configuration
COPY ./docker/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Set the document root and working directory
ENV WEB_DOCUMENT_ROOT=/app/web
WORKDIR /app