FROM snowdreamtech/frps:alpine

COPY --chown=frp:frp frp/frps.toml /etc/frp/frps.toml

# Expose necessary ports
EXPOSE 7000
EXPOSE 7500
EXPOSE 8080
EXPOSE 8443

ENTRYPOINT ["frps"]
CMD ["-c", "/etc/frp/frps.toml"]
