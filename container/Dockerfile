FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEFAULT_URL=about:blank

RUN apt-get update && apt-get install -y --no-install-recommends \
        xrdp xorgxrdp xserver-xorg-core xserver-xorg-video-dummy \
        xfonts-base x11-xserver-utils dbus-x11 openbox firefox-esr \
        ca-certificates procps tini sudo \
    && rm -rf /var/lib/apt/lists/*

COPY pam-xrdp-sesman /etc/pam.d/xrdp-sesman
COPY xrdp-auth.sh /usr/local/bin/xrdp-auth.sh
COPY firefox-session /usr/local/bin/firefox-session
COPY startwm.sh /etc/xrdp/startwm.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod 0755 /usr/local/bin/xrdp-auth.sh /usr/local/bin/firefox-session \
                /etc/xrdp/startwm.sh /usr/local/bin/entrypoint.sh \
 && mkdir -p /var/run/xrdp /run/xrdp /run/xrdp/sockdir \
 && chown xrdp:xrdp /var/run/xrdp /run/xrdp /run/xrdp/sockdir \
 && chmod 1777 /run/xrdp/sockdir \
 && adduser xrdp ssl-cert || true

EXPOSE 3389
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]
