#!/bin/sh

if [ -z "$HOST_SSH_PORT" ]; then
  echo "ERROR: HOST_SSH_PORT is not set!"
  exit 1
fi

# Substitute HOST_SSH_PORT in nginx template
envsubst '$HOST_SSH_PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Show final config (for debugging)
cat /etc/nginx/conf.d/default.conf

# Start nginx
nginx -g 'daemon off;'
