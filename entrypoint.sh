#!/bin/sh

if [ -z "$VPS_TUNNEL_PORT" ]; then
  echo "ERROR: VPS_TUNNEL_PORT is not set!"
  exit 1
fi

# Replace environment variable in Nginx template
envsubst '$VPS_TUNNEL_PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

echo ">>> Nginx configuration:"
cat /etc/nginx/conf.d/default.conf

# Start Nginx
nginx -g 'daemon off;'
