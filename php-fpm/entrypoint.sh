#!/bin/bash -x
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

# Run php-fpm
/usr/local/sbin/php-fpm --nodaemonize
