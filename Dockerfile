FROM nginx:alpine

# Install envsubst to replace environment variables
RUN apk add --no-cache bash gettext

# Copy Nginx template
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
