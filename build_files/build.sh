#!/bin/bash

set -ouex pipefail

systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

dnf -y install \
    uxplay     \

dnf -y copr enable yalter/niri
dnf -y copr disable yalter/niri
dnf -y --enablerepo copr:copr.fedorainfracloud.org:yalter:niri install niri
rm -rf /usr/share/doc/niri

dnf -y copr enable scottames/ghostty
dnf -y copr disable scottames/ghostty
dnf -y --enablerepo copr:copr.fedorainfracloud.org:scottames:ghostty install ghostty

dnf -y copr enable errornointernet/quickshell
dnf -y copr disable errornointernet/quickshell
dnf -y --enablerepo copr:copr.fedorainfracloud.org:errornointernet:quickshell install quickshell

mkdir -p /etc/skel/.config/quickshell/noctalia-shell
curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz \
    | tar -xz --strip-components=1 -C /etc/skel/.config/quickshell/noctalia-shell

mkdir -p /etc/niri

mkdir -p /usr/lib/systemd/user
cat << 'EOF' > /usr/lib/systemd/user/noctalia.service
[Unit]
Description=Noctalia Shell (Quickshell-based)

[Service]
ExecStart=/usr/bin/quickshell --config /etc/skel/.config/quickshell/noctalia-shell
Restart=on-failure

[Install]
WantedBy=default.target
EOF

echo "default_session=noctalia" > /etc/niri/niri.conf

dnf -y install \
    brightnessctl \
    gnome-keyring \
    nautilus \
    tuigreet \
    udiskie \
    wlsunset \
    cava \
    foot \

add_wants_niri() {
    sed -i "s/\[Unit\]/\[Unit\]\nWants=$1/" "/usr/lib/systemd/user/niri.service"
}
add_wants_niri noctalia.service
add_wants_niri plasma-polkit-agent.service
add_wants_niri swayidle.service
add_wants_niri udiskie.service
add_wants_niri xwayland-satellite.service
cat /usr/lib/systemd/user/niri.service

git clone "https://github.com/zirconium-dev/zdots.git" /usr/share/zirconium/zdots
cp -f /usr/share/zirconium/zdots/dot_config/niri/config.kdl /etc/niri/config.kdl

### fonts

dnf install -y \
    default-fonts-core-emoji \
    google-noto-fonts-all \
    google-noto-color-emoji-fonts \
    google-noto-emoji-fonts \
    glibc-all-langpacks

mkdir -p "/usr/share/fonts/Maple Mono"

MAPLE_TMPDIR="$(mktemp -d)"
trap 'rm -rf "${MAPLE_TMPDIR}"' EXIT

LATEST_RELEASE_FONT="$(curl "https://api.github.com/repos/subframe7536/maple-font/releases/latest" | jq '.assets[] | select(.name == "MapleMono-Variable.zip") | .browser_download_url' -rc)"
curl -fSsLo "${MAPLE_TMPDIR}/maple.zip" "${LATEST_RELEASE_FONT}"
unzip "${MAPLE_TMPDIR}/maple.zip" -d "/usr/share/fonts/Maple Mono"

