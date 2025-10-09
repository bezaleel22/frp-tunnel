# Use the official Rathole image
FROM rapiz1/rathole:v0.5.0

# Set environment variable at build time (or pass with --build-arg)
ARG PRIVATE_KEY
ENV PRIVATE_KEY=$PRIVATE_KEY

# Copy the template into the image
COPY ./config/server.toml /config/server.toml.template

# Render the template using sed during build
RUN sed "s|\${PRIVATE_KEY}|${PRIVATE_KEY}|g" /config/server.toml.template > /config/rathole.server.toml \
    && rm /config/server.toml.template

# Expose the Rathole server port (optional, depends on your config)
EXPOSE 2333

# Run Rathole directly
CMD ["rathole", "--server", "/config/rathole.server.toml"]
