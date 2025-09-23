#!/bin/sh

if [ -z "$VPS_TUNNEL_PORT" ]; then
  echo "ERROR: VPS_TUNNEL_PORT is not set!"
  exit 1
fi

# Substitute env vars in nginx template
# envsubst '$VPS_TUNNEL_PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# echo ">>> Final nginx.conf:"
# cat /etc/nginx/conf.d/default.conf

# Start nginx
nginx -g 'daemon off;'
