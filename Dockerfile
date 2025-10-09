# 🧱 Stage 1 — Build the config using sed
FROM alpine:3.19 AS builder

ARG PRIVATE_KEY
ENV PRIVATE_KEY=$PRIVATE_KEY

WORKDIR /app

# Copy the template
COPY ./config/server.toml .

# Render the template
RUN sed "s|\${PRIVATE_KEY}|${PRIVATE_KEY}|g" server.toml > rathole.server.toml

# 🧱 Stage 2 — Final Rathole image
FROM rapiz1/rathole:v0.5.0

# Copy the rendered config from the builder stage
COPY --from=builder /app/rathole.server.toml /config/rathole.server.toml

CMD ["--server", "/config/rathole.server.toml"]
