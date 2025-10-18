#!/bin/bash

set -ouex pipefail

systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf -y install \
    uxplay     \

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
dnf -y copr enable yalter/niri
dnf -y copr disable yalter/niri
dnf -y --enablerepo copr:copr.fedorainfracloud.org:yalter:niri install niri
rm -rf /usr/share/doc/niri

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
ExecStart=/usr/bin/quickshell --config %h/.config/quickshell/noctalia-shell
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

echo 'source /usr/share/bizzite/shell/pure.bash' | tee -a "/etc/bashrc"

#### Example for enabling a System Unit File

#systemctl enable podman.socket
