FROM		php:fpm-buster

ARG			NGINX_USER
ARG			NGINX_GROUP
ARG			NGINX_ROOT
ARG			NGINX_SERVER_NAME
ARG			PHP_SESSION_DIR
ARG			NEXTCLOUD_VER

ADD			. /php-fpm

RUN			\
			# Move Neccessary files for run
			mv /php-fpm/entrypoint.sh / && \
			chmod 775 /entrypoint.sh && \
			mv /php-fpm/config.php.template / && \
			# Update to latest
			apt -y update && \
			apt -y upgrade && \
			# Install neccessary packages
			apt -y install wget gettext-base && \
			# Install packages for nextcloud
			apt -y install libzip-dev libxml2-dev libonig-dev libpng-dev libcurl4-openssl-dev libfreetype6-dev libjpeg-dev libwebp-dev && \
			docker-php-ext-install zip xml mbstring curl pdo_mysql && \
			docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
			docker-php-ext-install -j$(nproc) gd && \
			docker-php-ext-enable zip xml mbstring gd curl pdo_mysql && \
			# Install opcache/apcu
			docker-php-ext-install opcache bcmath && \
			docker-php-ext-enable opcache bcmath && \
			pecl install apcu && \
			echo "extension=apcu.so" > ${PHP_INI_DIR}/conf.d/apcu.ini && \
			echo "apc.enable = 1" >> ${PHP_INI_DIR}/conf.d/apcu.ini && \
			echo "apc.enable_cli = 1" >> ${PHP_INI_DIR}/conf.d/apcu.ini && \
			ln -s ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini && \
			# Setup locale
			apt -y install locales && \
			echo "ja_JP UTF-8" > /etc/locale.gen && \
			locale-gen && \
			# Download nextcloud
			wget -q https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VER}.zip -O /nextcloud-${NEXTCLOUD_VER}.zip && \
			# Prepare PHP session directory
			mkdir -p ${PHP_SESSION_DIR} && \
			chown ${NGINX_USER}:${NGINX_USER} ${PHP_SESSION_DIR} && \
			chmod 770 ${PHP_SESSION_DIR} && \
			# Done
			echo "Build complete." 

ENTRYPOINT	sh /entrypoint.sh
