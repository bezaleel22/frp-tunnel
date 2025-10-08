FROM snowdreamtech/frps:alpine

COPY frp/frps.toml /etc/frp/frps.toml

# Expose necessary ports
EXPOSE 7000    # frps bind port (client connections)
EXPOSE 7500    # dashboard / web UI (if enabled)
EXPOSE 8080    # vhost HTTP (optional)
EXPOSE 8443    # vhost HTTPS (optional)

CMD ["-c", "/etc/frp/frps.toml"]
