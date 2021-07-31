FROM		debian:latest

ENV			NGINX_USER=www-data \
			NGINX_GROUP=www-data \
			NGINX_ROOT=/var/www/html \
			PHP_VER=7.3 \
			PHP_SESSION_DIR=/var/lib/php/sessions/ \
			NEXTCLOUD_VER=21.0.3

ADD 		. /php-fpm

RUN			\
			# Move entrypoint.sh
			mv /php-fpm/entrypoint.sh / && \
			chmod 775 /entrypoint.sh && \
			# Update to latest
			apt -y update && \
			apt -y upgrade && \
			# Install neccessary packages
			apt -y install wget php-fpm unzip php-zip php-xml php-mbstring php-gd php-curl php-sqlite3 && \
			# Setup php-fpm
			cat /php-fpm/php-fpm.conf > /etc/php/${PHP_VER}/fpm/php-fpm.conf && \
			mkdir -p /etc/php/${PHP_VER}/fpm/pool.d/ && \
			cat /php-fpm/pool.d/www.conf > /etc/php/${PHP_VER}/fpm/pool.d/www.conf && \
			rm -rf /php-fpm && \
			# Download nextcloud
			wget -q https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VER}.zip -O /nextcloud-${NEXTCLOUD_VER}.zip && \
			# Prepare PHP session directory
			mkdir -p ${PHP_SESSION_DIR} && \
			chown ${NGINX_USER}:${NGINX_USER} ${PHP_SESSION_DIR} && \
			chmod 770 ${PHP_SESSION_DIR} && \
			# Prepare directory for pid file
			mkdir -p /run/php && \
			# Done
			echo "Build complete." 

ENTRYPOINT	sh /entrypoint.sh