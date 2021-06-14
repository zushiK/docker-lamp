FROM php:7.4-apache

# ENV APACHE_DOCUMENT_ROOT /var/www/html/public
# RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
# RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# COPY ./php/php.ini /etc

RUN apt-get update \
  && apt-get install -y libonig-dev libpq-dev vim\
  && docker-php-ext-install pdo_mysql mbstring

# COPY ./apache/php/php.ini /usr/local/etc/php/php.ini
COPY ./docker/apache/httpd.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite 