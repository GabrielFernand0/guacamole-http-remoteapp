#!/bin/bash
set -e

IFS= read -r SUPPLIED_PASS || true
USER_NAME="${PAM_USER:-}"
MASTER_FILE="/run/rdp-master-password"

[ -n "$USER_NAME" ] || exit 1
[ -r "$MASTER_FILE" ] || exit 1
[[ "$USER_NAME" =~ ^[a-zA-Z0-9._-]{1,32}$ ]] || exit 1

MASTER_PASS="$(cat "$MASTER_FILE")"
[ -n "$MASTER_PASS" ] && [ "$SUPPLIED_PASS" = "$MASTER_PASS" ] || exit 1

if ! id "$USER_NAME" >/dev/null 2>&1; then
    useradd -m -s /bin/bash -G audio,video "$USER_NAME" >/dev/null 2>&1
    SESSION_PASS="$(head -c 32 /dev/urandom | base64 | tr -d '\n')"
    printf '%s:%s\n' "$USER_NAME" "$SESSION_PASS" | chpasswd >/dev/null 2>&1
fi
