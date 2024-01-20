#!/bin/bash -x
if [ ! -f ${CONTAINER_WEBROOT_DIR}/index.php ]; then
    cd  /;
    unzip -q /nextcloud-${NEXTCLOUD_VER}.zip;
    mv /nextcloud/* ${{CONTAINER_WEBROOT_DIR};
    envsubst '$$NGINX_SERVER_NAME' < /config.php.template > ${CONTAINER_WEBROOT_DIR}/config/config.php;
    chown -R ${NGINX_USER}:${NGINX_GROUP} ${CONTAINER_WEBROOT_DIR};
    rm -rf /nextcloud;
    rm /nextcloud-${NEXTCLOUD_VER}.zip;
    rm /config.php.template;
fi

# Run php-fpm
/usr/local/sbin/php-fpm --nodaemonize
