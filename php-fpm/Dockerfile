FROM		php:fpm

ARG			NGINX_USER
ARG			NGINX_GROUP
ARG			COTAINER_WEBROOT_DIR
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
			apt -y install unzip iproute2 libzip-dev libxml2-dev libonig-dev libpng-dev libfreetype6-dev libjpeg-dev libwebp-dev libmagickwand-dev ffmpeg imagemagick ghostscript libcurl4-openssl-dev libgmp-dev fuse && \
			docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
			docker-php-ext-install zip xml mbstring curl gd pdo_mysql intl gmp exif sysvsem && \
			docker-php-ext-enable zip xml mbstring curl gd pdo_mysql intl gmp exif sysvsem && \
			# Install library for Gmail
			apt -y install python3-pip && \
			apt -y install python3-googleapi python3-google-auth-oauthlib && \
			# Install Imagick
			yes '' | pecl install imagick && \
			echo "extension=imagick.so" > ${PHP_INI_DIR}/conf.d/imagick.ini && \
			# Install opcache/apcu
			docker-php-ext-install opcache bcmath && \
			docker-php-ext-enable opcache bcmath && \
			pecl install apcu && \
			echo "extension=apcu.so" > ${PHP_INI_DIR}/conf.d/apcu.ini && \
			ln -s ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini && \
			# Setup locale
			apt -y install locales && \
			echo "en_US UTF-8" > /etc/locale.gen && \
			locale-gen && \
			# auto_prepend_file
			echo '<?php setlocale(LC_CTYPE, "en_US.UTF-8");' > /var/www/prepend.php && \
			chown www-data /var/www/prepend.php && \
			# Download nextcloud
			wget -q https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VER}.zip -O /nextcloud-${NEXTCLOUD_VER}.zip && \
			# Prepare PHP session directory
			mkdir -p ${PHP_SESSION_DIR} && \
			chown ${NGINX_USER}:${NGINX_USER} ${PHP_SESSION_DIR} && \
			chmod 770 ${PHP_SESSION_DIR} && \
			# Done
			echo "Build complete."
