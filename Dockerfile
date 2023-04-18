FROM alpine:3.14
RUN apk add --no-cache mysql-client
RUN mkdir -p /var/www/html/ && chmod 777 /var/www/html/
# Установить зависимости для WP-CLI
RUN apk add --no-cache \
        less \
        php7 \
        php7-curl \
        php7-json \
        php7-mbstring \
        php7-mysqli \
        php7-phar \
        php7-openssl \
        php7-dom \
        php7-xml \
        php7-xmlwriter \
        php7-simplexml
# Скачать и установить WP-CLI
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp
# Set the server name and login credentials
ENV SERVER_NAME mysql-wpmax.mysql.database.azure.com
ENV USER_NAME mysqladmin@mysql-wpmax
ENV PASSWORD 1-qwerty
# Connect to the MySQL server and create a new database
CMD mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
    CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');" &&\
# Configure WP-CLI and install plugins and themes
# Configure WP-CLI and install plugins and themes
wp core download --path=/var/www/html --allow-root && \
wp --allow-root --path=/var/www/html config create \
  --dbhost=mysql-wpmax.mysql.database.azure.com \
  --dbname=test_manifest12 \
  --dbuser=mysqladmin@mysql-wpmax \
  --dbpass=1-qwerty \
  --allow-root && \
wp --allow-root --path=/var/www/html core install \
  --url=http://localhost \
  --title=MyWebsite \
  --admin_user=admin \
  --admin_password=admin \
  --admin_email=admin@example.com  &&\
wp --allow-root --path=/var/www/html plugin install contact-form-7 --activate && \
wp --allow-root --path=/var/www/html theme install twentyseventeen && \
wp --allow-root --path=/var/www/html theme activate twentyseventeen

 