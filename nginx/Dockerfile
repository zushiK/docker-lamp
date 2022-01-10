FROM nginx:1.18-alpine
ENV PHP_HOST php
ADD ./docker/nginx1/nginx.conf.template /etc/nginx/conf.d/default.conf.template
RUN envsubst '$$PHP_HOST' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/public
ADD ./php1/php1/public /var/www/public
