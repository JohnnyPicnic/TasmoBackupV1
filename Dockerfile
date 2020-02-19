ARG BUILD_FROM=php:7.2-apache
FROM ${BUILD_FROM}
MAINTAINER Dan Medhurst (danmed@gmail.com)
COPY qemu-*-static /usr/bin/
COPY *.php /var/www/html/
COPY *.png /var/www/html/
COPY *.sh /var/www/html/
COPY *.example /var/www/html/
COPY resources /var/www/html/resources
COPY lib /var/www/html/lib
RUN echo "Start" \
 && mv /var/www/html/install.sh /usr/local/bin/install.sh \
 && chmod 755 /usr/local/bin/install.sh \
 && echo 'PassEnv DBTYPE'  >> /etc/apache2/conf-enabled/expose-env.conf \
 && echo 'PassEnv DBNAME'   >> /etc/apache2/conf-enabled/expose-env.conf \
 && echo 'PassEnv MYSQL_SERVER'  >> /etc/apache2/conf-enabled/expose-env.conf \
 && echo 'PassEnv MYSQL_USERNAME'  >> /etc/apache2/conf-enabled/expose-env.conf \
 && echo 'PassEnv MYSQL_PASSWORD'  >> /etc/apache2/conf-enabled/expose-env.conf \
 && docker-php-ext-install mysqli pdo_mysql opcache \
 && echo "Done"
CMD [ "/usr/local/bin/install.sh", "apache2-foreground" ]
