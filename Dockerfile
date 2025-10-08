FROM snowdreamtech/frps:alpine

COPY frp/frps.toml /etc/frp/frps.toml

# Expose necessary ports
EXPOSE 7000
EXPOSE 7500
EXPOSE 8080
EXPOSE 8443

CMD ["-c", "/etc/frp/frps.toml"]
