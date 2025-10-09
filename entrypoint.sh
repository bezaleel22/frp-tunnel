#!/usr/bin/env sh
set -e

TEMPLATE_FILE="/config/server.toml.template"
OUTPUT_FILE="/config/rathole.server.toml"

# Replace ${PRIVATE_KEY} in the template with the actual env value
sed "s|\${PRIVATE_KEY}|${PRIVATE_KEY}|g" "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "✅ Rathole configuration rendered:"
cat "$OUTPUT_FILE"

# Start Rathole with the rendered config
exec rathole --server "$OUTPUT_FILE"