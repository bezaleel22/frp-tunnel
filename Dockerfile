# Dockerfile
FROM nginx:alpine

# Install envsubst to substitute env vars in nginx config
RUN apk add --no-cache bash gettext

# Copy nginx template
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Entrypoint script to replace env vars in nginx template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose standard HTTP port
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
