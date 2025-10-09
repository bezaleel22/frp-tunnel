#!/usr/bin/env sh
set -e

# Replace environment variables in the template
envsubst < /config/server.toml.template > /config/rathole.server.toml

echo "✅ Rathole configuration rendered:"
cat /config/rathole.server.toml

# Run Rathole
exec rathole --server /config/rathole.server.toml