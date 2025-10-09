
FROM rapiz1/rathole:v0.5.0
RUN apk add --no-cache gettext

# Copy the template and entrypoint
COPY ./config/server.toml /config/server.toml.template
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2333

ENTRYPOINT ["/entrypoint.sh"]
