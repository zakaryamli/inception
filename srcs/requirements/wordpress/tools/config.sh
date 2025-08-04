#!/bin/bash

# wp-cli instalation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# set permissions in world press directory
cd /var/www/html && chmod -R 755 /var/www/html && chown -R www-data:www-data /var/www/html

# wait for mariadb to connect
max_retries=10
attempt=1

while [ $attempt -le $max_retries ]; do
    if mariadb -h mariadb -P 3306 \
        -u "${INCEPTION_MYSQL_USER}" \
        -p"${INCEPTION_MYSQL_PASS}" \
        -e "SELECT 1" > /dev/null 2>&1; then
        break
    else
        sleep 2
        attempt=$((attempt + 1))
    fi
done

# download wordpress core
wp core download --allow-root

# create wp-config.php file with database details
wp config create \
    --dbname=${INCEPTION_MYSQL_DATABASE} \
    --dbuser=${INCEPTION_MYSQL_USER} \
    --dbpass=${INCEPTION_MYSQL_PASS} \
    --dbhost=mariadb:3306 --allow-root
# install wordpress with my details
wp core install \
    --url=${INCEPTION_DOMAIN_NAME} \
    --title=${INCEPTION_WP_TITLE} \
    --admin_user=${INCEPTION_WP_A_NAME} \
    --admin_password=${INCEPTION_WP_A_PASS} \
    --admin_email=${INCEPTION_WP_A_EMAIL} --allow-root
# create user
wp user create ${INCEPTION_WP_U_NAME} ${INCEPTION_WP_U_EMAIL} \
    --user_pass=${INCEPTION_WP_U_PASS} \
    --role=${INCEPTION_WP_U_ROLE} --allow-root

# change listen from unix-socket to TCP port 9000
sed -i '36 s/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf

# install theme
wp theme install twentytwentyfour --activate --allow-root

#create php-fpm directory and run php-fpm in the forground
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
