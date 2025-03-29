FROM php:8.4-fpm-alpine

COPY ./docker/php/php.ini "$PHP_INI_DIR/php.ini"

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions xdebug \
    @composer \
    mysqli \
    exif \
    imagick \
    zip \
    gd \
    intl \
    apcu \
    opcache \
    && docker-php-ext-enable xdebug apcu

COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /var/www/html

COPY ./composer.json /var/www/html/composer.json
RUN composer install --no-interaction
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

