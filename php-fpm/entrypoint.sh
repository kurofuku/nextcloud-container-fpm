#!/bin/sh
if [ ! -f ${NGINX_ROOT}index.php ]; then
    cd  /;
    unzip -q /nextcloud-${NEXTCLOUD_VER}.zip;
    mv /nextcloud/* ${NGINX_ROOT};
    chown -R ${NGINX_USER}:${NGINX_GROUP} ${NGINX_ROOT};
    rm -rf /nextcloud;
    rm /nextcloud-${NEXTCLOUD_VER}.zip;
fi
# Run php-fpm
/usr/sbin/php-fpm${PHP_VER} --nodaemonize --fpm-config /etc/php/${PHP_VER}/fpm/php-fpm.conf
