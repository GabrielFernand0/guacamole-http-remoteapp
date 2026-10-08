#!/bin/bash
set -e

if [ -z "${RDP_MASTER_PASSWORD:-}" ]; then
    echo "ERROR: RDP_MASTER_PASSWORD must be set" >&2
    exit 1
fi

umask 077
printf '%s' "$RDP_MASTER_PASSWORD" > /run/rdp-master-password
chmod 600 /run/rdp-master-password

cat > /etc/xrdp/xrdp-env <<EOF
DEFAULT_URL=${DEFAULT_URL:-about:blank}
EOF
chmod 0644 /etc/xrdp/xrdp-env

mkdir -p /var/run/xrdp /run/xrdp /run/xrdp/sockdir /run/dbus
chown xrdp:xrdp /var/run/xrdp /run/xrdp /run/xrdp/sockdir || true
chmod 0755 /run/xrdp
chmod 1777 /run/xrdp/sockdir

if command -v dbus-daemon >/dev/null 2>&1 && [ ! -S /run/dbus/system_bus_socket ]; then
    dbus-daemon --system --fork --nopidfile 2>/dev/null || true
fi

if [ ! -s /etc/xrdp/rsakeys.ini ]; then
    xrdp-keygen xrdp auto >/dev/null 2>&1 || true
fi

/usr/sbin/xrdp-sesman --nodaemon &
SESMAN_PID=$!
sleep 1
/usr/sbin/xrdp --nodaemon &
XRDP_PID=$!

shutdown() {
    kill -TERM "$XRDP_PID" "$SESMAN_PID" 2>/dev/null || true
    wait "$XRDP_PID" "$SESMAN_PID" 2>/dev/null || true
    exit 0
}
trap shutdown TERM INT
wait -n "$XRDP_PID" "$SESMAN_PID"
EXIT_CODE=$?
shutdown
exit "$EXIT_CODE"
