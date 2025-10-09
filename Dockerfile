# Use the official Rathole image as the base
FROM rapiz1/rathole:v0.5.0
COPY ./config/server.toml /config/rathole.server.toml
EXPOSE 2333

CMD ["--server", "/config/rathole.server.toml"]