FROM		debian:latest

ARG			NGINX_USER
ARG			NGINX_GROUP
ARG			NGINX_ROOT
ARG			NGINX_SERVER_NAME
ARG			PHP_VER
ARG			PHP_SESSION_DIR
ARG			NEXTCLOUD_VER

ADD 		. /php-fpm

RUN			\
			# Move Neccessary files for run
			mv /php-fpm/entrypoint.sh / && \
			chmod 775 /entrypoint.sh && \
			mv /php-fpm/config.php.template / && \
			# Update to latest
			apt -y update && \
			apt -y upgrade && \
			# Install neccessary packages
			apt -y install wget php-fpm unzip php-zip php-xml php-mbstring php-gd php-curl php-mysql gettext-base && \
			# Setup php-fpm
			cp /php-fpm/php-fpm.conf.template /etc/php/${PHP_VER}/fpm/php-fpm.conf.template && \
			mkdir -p /etc/php/${PHP_VER}/fpm/pool.d/ && \
			cp /php-fpm/pool.d/www.conf.template /etc/php/${PHP_VER}/fpm/pool.d/www.conf.template && \
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