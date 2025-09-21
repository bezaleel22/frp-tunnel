#!/bin/sh
# Substitute HOST_SSH_PORT in nginx template
envsubst '$HOST_SSH_PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Start nginx
nginx -g 'daemon off;'
