FROM nginx:alpine
RUN apk add --no-cache gettext

ARG HOST_SSH_PORT=5555
ENV HOST_SSH_PORT=${HOST_SSH_PORT}

COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Substitute variable at build-time
RUN envsubst '$HOST_SSH_PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
