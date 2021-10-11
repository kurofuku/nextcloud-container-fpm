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
cat > ${PHP_INI_DIR}-fpm.d/zz-docker.conf << EOF
[www]
user = ${NGINX_USER}
group = ${NGINX_GROUP}

listen = /var/run/php-fpm.sock
listen.owner = ${NGINX_USER}
listen.group = ${NGINX_GROUP}
listen.mode = 660

;php_value[opcache.enable] = 1
;php_value[opcache.enable_cli] = 1
php_value[opcache.interned_strings_buffer] = 8
php_value[opcache.max_accelerated_files] = 10000
php_value[opcache.memory_consumption] = 128
php_value[opcache.save_comments] = 1
php_value[opcache.revalidate_freq] = 1
php_value[opcache.file_cache] = /var/lib/php/opcache
php_value[session.save_handler] = files
php_value[session.save_path] = /${PHP_SESSION_DIR}
;php_value[soap.wsdl_cache_dir] = /var/lib/php/wsdlcache
EOF
# Extend max_execution_time
sed -i -e "s/max_execution_time = 30/max_execution_time = 180/" ${PHP_INI_DIR}/php.ini
# Run php-fpm
/usr/local/sbin/php-fpm --nodaemonize
