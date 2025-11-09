#!/bin/bash

set -ouex pipefail
cp -avf /ctx/files/. /

# COPRs, DMS

dnf -y copr enable yalter/niri-git
dnf -y copr disable yalter/niri-git
echo "priority=1" | tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:yalter:niri-git.repo
dnf -y --enablerepo copr:copr.fedorainfracloud.org:yalter:niri-git install niri
rm -rf /usr/share/doc/niri

dnf5 -y copr enable errornointernet/quickshell
dnf5 -y copr disable errornointernet/quickshell
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:errornointernet:quickshell install quickshell-git

dnf5 -y copr enable purian23/material-symbols-fonts
dnf5 -y copr disable purian23/material-symbols-fonts
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:purian23:material-symbols-fonts install material-symbols-fonts

dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr disable avengemedia/danklinux
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:avengemedia:danklinux install \
     hyprpicker \
     dgop \
     brightnessctl \
     cava \
     accountsservice

dnf -y copr enable avengemedia/dms-git
dnf -y copr disable avengemedia/dms-git
dnf -y \
    --enablerepo copr:copr.fedorainfracloud.org:avengemedia:dms-git \
    --enablerepo copr:copr.fedorainfracloud.org:avengemedia:danklinux \
    install --setopt=install_weak_deps=False \
    dms \
    dms-cli \
    dms-greeter

dnf5 -y copr enable scottames/ghostty
dnf5 -y copr disable scottames/ghostty
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:scottames:ghostty install ghostty

dnf5 -y copr enable zirconium/packages
dnf5 -y copr disable zirconium/packages
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:zirconium:packages install \
    matugen \
    cliphist

mkdir -p /etc/xdg/quickshell
if [ -d /etc/xdg/quickshell/dms ]; then
    rm -rf /etc/xdg/quickshell/dms
fi

git clone https://github.com/AvengeMedia/DankMaterialShell.git /etc/xdg/quickshell/dms


# bazzite stuff
dnf5 -y copr enable ycollet/audinux
dnf5 -y copr enable bazzite-org/bazzite  
dnf5 -y copr enable bazzite-org/bazzite-multilib  
dnf5 -y copr enable bazzite-org/LatencyFleX  
dnf5 -y copr enable bazzite-org/obs-vkcapture  
dnf5 -y copr enable bazzite-org/webapp-manager

dnf5 -y install \
     steam \
     mangohud \
     gamescope \
     gamescope-libs \
     lutris \
     vulkan-tools \
     gamescope-shaders \
     python3-pip \
     python3-icoextract \
     ds-inhibit \
     lsb_release \
     cpulimit \

## bazzite repos  
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:bazzite-org:bazzite \
    install --skip-broken vkBasalt.x86_64 VK_hdr_layer sunshine ryzenadj

dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:bazzite-org:bazzite-multilib install \
    vkBasalt.i686

## LatencyFleX 
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:bazzite-org:LatencyFleX install \
    latencyflex-vulkan-layer --skip-unavailable

## obs-vkcapture 
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:bazzite-org:obs-vkcapture install \
    libobs_vkcapture.x86_64 \
    libobs_glcapture.x86_64 \
    libobs_vkcapture.i686 \
    libobs_glcapture.i686

## webapp-manager
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:bazzite-org:webapp-manager install \
    webapp-manager

dnf5 -y install \
     xone-kmod \
     i2c-tools \
     libcec \
     umu-launcher

dnf5 -y copr disable bazzite-org/bazzite
dnf5 -y copr disable bazzite-org/bazzite-multilib
dnf5 -y copr disable bazzite-org/LatencyFleX
dnf5 -y copr disable bazzite-org/obs-vkcapture
dnf5 -y copr disable bazzite-org/webapp-manager


# main packages ig lol
dnf5 -y remove alacritty

dnf5 -y install \
     hyfetch \
     greetd \
     greetd-selinux \
     steam-devices \
     udiskie \
     wlsunset \
     xdg-desktop-portal-wlr \
     wl-clipboard \
     swaylock \
     swayidle \
     tuigreet \
     adw-gtk3-theme \
     python3-vdirsyncer \
     khal \
     python3-aiohttp-oauthlib \
     kde-connect \
     kde-connect-libs \
     kde-connect-nautilus \
     kdeconnectd \
     uxplay \
     input-remapper \
     v4l-utils \
     openhmd \
     waydroid \
     libinput-utils \
     ladspa-caps-plugins \
     ladspa-noise-suppression-for-voice \
     pipewire-module-filter-chain-sofa \
     duperemove \
     compsize \
     cage \
     snapper \
     btrfs-assistant \
     rar \
     lzip \
     kmenuedit \
     dolphin \
     glycin-thumbnailer \
     webp-pixbuf-loader \
     google-roboto-fonts


# amd stuff
dnf5 -y install \
     rocm-hip \
     rocm-opencl \
     rocm-clinfo\
     rocm-smi


# qt stuff
dnf5 -y install --setopt=install_weak_deps=False \
    kf6-kirigami \
    qt6ct \
    polkit-kde \
    plasma-breeze \
    kf6-qqc2-desktop-style


# vinceliuice mactahoe-gtk-theme
dnf5 -y install \
     sassc \
     glib2-devel


# mullvad vpn
dnf5 -y config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
dnf5 -y install mullvad-vpn


# zirconium stuff i yanked
sed -i '/gnome_keyring.so/ s/-auth/auth/ ; /gnome_keyring.so/ s/-session/session/' /etc/pam.d/greetd
cat /etc/pam.d/greetd


sed -i "s/After=.*/After=graphical-session.target/" /usr/lib/systemd/user/plasma-polkit-agent.service

add_wants_niri() {
    sed -i "s/\[Unit\]/\[Unit\]\nWants=$1/" "/usr/lib/systemd/user/niri.service"
}
add_wants_niri noctalia.service
add_wants_niri plasma-polkit-agent.service
#
add_wants_niri udiskie.service
add_wants_niri xwayland-satellite.service
cat /usr/lib/systemd/user/niri.service


# services
systemctl disable gdm
systemctl enable greetd

systemctl enable --global plasma-polkit-agent.service
systemctl enable --global dms.service
#systemctl enable --global swayidle.service
#systemctl enable --global udiskie.service
systemctl enable --global xwayland-satellite.service


# fonts
dnf5 -y install \
    default-fonts-core-emoji \
    google-noto-color-emoji-fonts \
    google-noto-emoji-fonts \
    glibc-all-langpacks \
    default-fonts \
    twitter-twemoji-fonts


## DMS
curl -L "https://github.com/google/material-design-icons/raw/master/variablefont/MaterialSymbolsRounded%5BFILL%2CGRAD%2Copsz%2Cwght%5D.ttf" -o /usr/share/fonts/MaterialSymbolsRounded.ttf
curl -L "https://github.com/rsms/inter/raw/refs/tags/v4.1/docs/font-files/InterVariable.ttf" -o /usr/share/fonts/InterVariable.ttf
curl -L "https://github.com/tonsky/FiraCode/releases/latest/download/FiraCode-Regular.ttf" -o /usr/share/fonts/FiraCode-Regular.ttf


## Zirconium's Niri dotfiles
git clone "https://github.com/zirconium-dev/zdots.git" /usr/share/bifin/zdots
install -d /etc/niri/
cp -rf /usr/share/bifin/zdots/dot_config/niri/* /etc/niri/
cp -f /usr/share/bifin/zdots/dot_config/niri/config.kdl /etc/niri/config.kdl
file /etc/niri/config.kdl | grep -F -e "empty" -v
stat /etc/niri/config.kdl

## Maple Mono
mkdir -p "/usr/share/fonts/Maple_Mono"

MAPLE_TMPDIR="$(mktemp -d)"
trap 'rm -rf "${MAPLE_TMPDIR}"' EXIT

LATEST_RELEASE_FONT="$(curl "https://api.github.com/repos/subframe7536/maple-font/releases/latest" | jq '.assets[] | select(.name == "MapleMono-Variable.zip") | .browser_download_url' -rc)"
curl -fSsLo "${MAPLE_TMPDIR}/maple.zip" "${LATEST_RELEASE_FONT}"
unzip "${MAPLE_TMPDIR}/maple.zip" -d "/usr/share/fonts/Maple Mono"


# Fancy
HOME_URL="https://github.com/matthias-adr/bifin"
echo "bifin" | tee "/etc/hostname"

sed -i -f - /usr/lib/os-release <<EOF
s|^NAME=.*|NAME=\"Bifin\"|
s|^PRETTY_NAME=.*|PRETTY_NAME=\"Bifin\"|
s|^VERSION_CODENAME=.*|VERSION_CODENAME=\"Posture\"|
s|^VARIANT_ID=.*|VARIANT_ID=""|
s|^HOME_URL=.*|HOME_URL=\"${HOME_URL}\"|
s|^CPE_NAME=\".*\"|CPE_NAME=\"cpe:/o:matthias-adr:bifin\"|
s|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL=\"${HOME_URL}\"|
s|^DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME="bifin"|

/^REDHAT_BUGZILLA_PRODUCT=/d
/^REDHAT_BUGZILLA_PRODUCT_VERSION=/d
/^REDHAT_SUPPORT_PRODUCT=/d
/^REDHAT_SUPPORT_PRODUCT_VERSION=/d
EOF

cat <<EOF > /etc/sysctl.d/99-bbr.conf
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
