FROM alpine:3.14
RUN apk add --no-cache mysql-client



# Set the server name and login credentials
ENV SERVER_NAME mysql-wpmax.mysql.database.azure.com
ENV USER_NAME mysqladmin@mysql-wpmax
ENV PASSWORD 1-qwerty

# Connect to the MySQL server and create a new database

CMD mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
    CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');
    
# Configure WP-CLI and install plugins and themes
RUN apk add --no-cache curl bash
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN apk add --no-cache php7 && \
    wp --allow-root core install \
    --url=http://localhost \
    --title=MyWebsite \
    --admin_user=admin \
    --admin_password=admin \
    --admin_email=admin@example.com

RUN wp --allow-root plugin install contact-form-7 --activate
RUN wp --allow-root theme install twentyseventeen && wp --allow-root theme activate twentyseventeen
    