#!/bin/bash
#
# tunnel.sh - SSH tunnel manager with automatic systemd service and removal
#

# === Load .env ===
ENV_FILE="${ENV_FILE:-.env}"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

# === FUNCTIONS ===
install_service() {
    SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
    SUDO="sudo"

    if [ -f "$SERVICE_FILE" ]; then
        echo "Systemd service ${SERVICE_NAME} already exists. Skipping installation."
        return
    fi

    echo "Installing systemd service ${SERVICE_NAME}..."
    $SUDO tee $SERVICE_FILE > /dev/null <<EOF
[Unit]
Description=Persistent SSH Tunnel for local port ${LOCAL_PORT}
After=network.target

[Service]
Type=simple
User=${USER}
Environment="REMOTE_USER=${REMOTE_USER}"
Environment="REMOTE_HOST=${REMOTE_HOST}"
Environment="SSH_KEY=${SSH_KEY}"
Environment="LOCAL_PORT=${LOCAL_PORT}"
Environment="REMOTE_SERVICE_PORT=${REMOTE_SERVICE_PORT}"
Environment="LOGFILE=${LOGFILE}"
ExecStart=${PWD}/$(basename $0) start
Restart=always
RestartSec=5
StandardOutput=append:${LOGFILE}
StandardError=append:${LOGFILE}

[Install]
WantedBy=multi-user.target
EOF

    echo "Reloading systemd daemon..."
    $SUDO systemctl daemon-reload
    echo "Enabling service..."
    $SUDO systemctl enable ${SERVICE_NAME}
    echo "Starting service..."
    $SUDO systemctl start ${SERVICE_NAME}
    echo "Service ${SERVICE_NAME} installed and running."
}

start_tunnel() {
    echo "Starting SSH tunnel..."
    echo "Forwarding localhost:${LOCAL_PORT} -> localhost:${REMOTE_SERVICE_PORT} on ${REMOTE_USER}@${REMOTE_HOST}"
    exec ssh -N \
        -o "ExitOnForwardFailure yes" \
        -o "ServerAliveInterval 60" \
        -o "ServerAliveCountMax 3" \
        -L 127.0.0.1:${LOCAL_PORT}:127.0.0.1:${REMOTE_SERVICE_PORT} \
        -i "${SSH_KEY}" \
        ${REMOTE_USER}@${REMOTE_HOST} >> "${LOGFILE}" 2>&1
}

stop_tunnel() {
    sudo systemctl stop ${SERVICE_NAME}
}

restart_tunnel() {
    sudo systemctl restart ${SERVICE_NAME}
}

status_tunnel() {
    sudo systemctl status ${SERVICE_NAME}
}

remove_tunnel() {
    echo "Removing systemd service ${SERVICE_NAME}..."
    sudo systemctl stop ${SERVICE_NAME} 2>/dev/null
    sudo systemctl disable ${SERVICE_NAME} 2>/dev/null
    sudo rm -f /etc/systemd/system/${SERVICE_NAME}.service
    sudo systemctl daemon-reload
    echo "Service ${SERVICE_NAME} removed."
}

# === MAIN ===
case "$1" in
    install)
        install_service
        ;;
    start)
        start_tunnel
        ;;
    stop)
        stop_tunnel
        ;;
    restart)
        restart_tunnel
        ;;
    status)
        status_tunnel
        ;;
    remove)
        remove_tunnel
        ;;
    *)
        echo "Usage: $0 {install|start|stop|restart|status|remove}"
        exit 1
        ;;
esac
