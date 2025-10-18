#!/bin/bash

set -ouex pipefail

systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

dnf -y copr enable yalter/niri
dnf -y copr disable yalter/niri
dnf -y --enablerepo copr:copr.fedorainfracloud.org:yalter:niri install niri
rm -rf /usr/share/doc/niri

dnf -y copr enable scottames/ghostty
dnf -y copr disable scottames/ghostty
dnf -y --enablerepo copr:copr.fedorainfracloud.org:scottames:ghostty install ghostty

dnf -y copr enable alternateved/cliphist
dnf -y copr disable alternateved/cliphist
dnf -y --enablerepo copr:copr.fedorainfracloud.org:alternateved:cliphist install cliphist

dnf -y copr enable errornointernet/quickshell
dnf -y copr disable errornointernet/quickshell
dnf -y --enablerepo copr:copr.fedorainfracloud.org:errornointernet:quickshell install quickshell

dnf -y copr enable brycensranch/gpu-screen-recorder-git
dnf -y --enablerepo copr:copr.fedorainfracloud.org:brycensranch:gpu-screen-recorder-git install gpu-screen-recorder-ui
dnf -y copr disable brycensranch/gpu-screen-recorder-git


dnf -y install \
    uxplay \
    udiskie \
    xdg-desktop-portal-gnome \
    swaybg \
    swayidle \
    swaylock \
    brightnessctl \
    gnome-keyring \
    greetd \
    greetd-selinux \
    nautilus \
    tuigreet \
    udiskie \
    wlsunset \
    xdg-user-dirs \
    xwayland-satellite \
    cava \
    fuzzel \


systemctl disable sddm
systemctl enable greetd
systemctl enable firewalld
systemctl enable podman.socket
systemctl enable podman.service


add_wants_niri() {
    sed -i "s/\[Unit\]/\[Unit\]\nWants=$1/" "/usr/lib/systemd/user/niri.service"
}
add_wants_niri noctalia.service
add_wants_niri plasma-polkit-agent.service
add_wants_niri swayidle.service
add_wants_niri udiskie.service
add_wants_niri xwayland-satellite.service
cat /usr/lib/systemd/user/niri.service


sed -i '/gnome_keyring.so/ s/-auth/auth/ ; /gnome_keyring.so/ s/-session/session/' /etc/pam.d/greetd
cat /etc/pam.d/greetd


dnf install -y --setopt=install_weak_deps=False \
    polkit-kde

sed -i "s/After=.*/After=graphical-session.target/" /usr/lib/systemd/user/plasma-polkit-agent.service


dnf -y install --enablerepo=fedora-multimedia \
    ffmpeg libavcodec @multimedia gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} libjxl ffmpegthumbnailer


sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|^OnUnitInactiveSec=.*|OnUnitInactiveSec=7d\nPersistent=true|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf

cp -avf "/ctx/files"/. /
mkdir -p /etc/skel/Pictures/Wallpapers
ln -s /usr/share/bizzite/skel/Pictures/Wallpapers/ublue.png /etc/skel/Pictures/Wallpapers/ublue.png


systemctl enable --global noctalia.service
systemctl enable --global plasma-polkit-agent.service
systemctl enable --global swayidle.service
systemctl enable --global udiskie.service
systemctl enable --global xwayland-satellite.service
systemctl preset --global noctalia
systemctl preset --global plasma-polkit-agent
systemctl preset --global swayidle
systemctl preset --global udiskie
systemctl preset --global xwayland-satellite


git clone "https://github.com/noctalia-dev/noctalia-shell.git" /usr/share/bizzite-experi/noctalia-shell
install -d /etc/niri/
cp -f /usr/share/bizzite-experi/zdots/dot_config/niri/config.kdl /etc/niri/config.kdl


mkdir -p "/usr/share/fonts/Maple Mono"

MAPLE_TMPDIR="$(mktemp -d)"
trap 'rm -rf "${MAPLE_TMPDIR}"' EXIT

LATEST_RELEASE_FONT="$(curl "https://api.github.com/repos/subframe7536/maple-font/releases/latest" | jq '.assets[] | select(.name == "MapleMono-Variable.zip") | .browser_download_url' -rc)"
curl -fSsLo "${MAPLE_TMPDIR}/maple.zip" "${LATEST_RELEASE_FONT}"
unzip "${MAPLE_TMPDIR}/maple.zip" -d "/usr/share/fonts/Maple Mono"

