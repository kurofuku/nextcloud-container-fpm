#!/bin/sh
if [ ! -f /etc/letsencrypt/live/${NGINX_SERVER_NAME}/fullchain.pem ]; then
	certbot certonly -n --webroot -w "${NGINX_ROOT}" --email "${MAIL_ADDRESS}" --agree-tos -d "${NGINX_SERVER_NAME}" -d "${NGINX_WWW_SERVER_NAME}";
fi

sleep 65535