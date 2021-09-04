#!/bin/sh
rm -f /etc/nginx/conf.d/*.conf

envsubst '$$NGINX_USER' < /nginx/nginx.conf.template > /etc/nginx/nginx.conf

if [ -f /etc/letsencrypt/live/${NGINX_SERVER_NAME}/fullchain.pem ]; then
	envsubst '$$PHP_VER$$NGINX_SERVER_NAME$$NGINX_WWW_SERVER_NAME$$NGINX_ROOT' < /nginx/conf.d/http.conf.template > /etc/nginx/conf.d/http.conf;
else
	envsubst '$$PHP_VER$$NGINX_SERVER_NAME$$NGINX_WWW_SERVER_NAME$$NGINX_ROOT' < /nginx/conf.d/http.conf.template > /etc/nginx/conf.d/http.conf;
fi

nginx -g 'daemon off;'