#!/bin/sh -x
if [ ! -f ${NGINX_ROOT}/index.php ]; then
    cd  /;
    unzip -q /nextcloud-${NEXTCLOUD_VER}.zip;
    mv /nextcloud/* ${NGINX_ROOT};
    envsubst '$$NGINX_SERVER_NAME' < /config.php.template > ${NGINX_ROOT}/config/config.php;
    chown -R ${NGINX_USER}:${NGINX_GROUP} ${NGINX_ROOT};
    rm -rf /nextcloud;
    rm /nextcloud-${NEXTCLOUD_VER}.zip;
    rm /config.php.template;
fi
# Replace environment variables to real value
envsubst '$$PHP_VER' < /etc/php/${PHP_VER}/fpm/php-fpm.conf.template > /etc/php/${PHP_VER}/fpm/php-fpm.conf
envsubst '$$PHP_VER$$NGINX_USER$$NGINX_GROUP$$PHP_SESSION_DIR' < /etc/php/${PHP_VER}/fpm/pool.d/www.conf.template > /etc/php/${PHP_VER}/fpm/pool.d/www.conf
# Run php-fpm
/usr/sbin/php-fpm${PHP_VER} --nodaemonize --fpm-config /etc/php/${PHP_VER}/fpm/php-fpm.conf
