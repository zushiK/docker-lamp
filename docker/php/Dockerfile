FROM php:7.3-fpm-alpine3.11
RUN apk add --no-cache --update oniguruma-dev libzip-dev
# lumen packages
RUN docker-php-ext-install mbstring tokenizer zip pdo_mysql
RUN apk add --no-cache --update  zlib

RUN set -xe \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/20_redis.ini \
    && rm -rf /usr/share/php7 \
    && rm -rf /tmp/* \
    && apk del .phpize-deps

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/