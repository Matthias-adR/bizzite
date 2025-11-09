# <img width="312" height="105" alt="cooltext495840317641929" src="https://github.com/user-attachments/assets/5d152893-0885-4bbe-8e41-ce81e2771a63" />

[![Build container image](https://github.com/Matthias-adR/bizzite/actions/workflows/build.yml/badge.svg)](https://github.com/Matthias-adR/bizzite/actions/workflows/build.yml) [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/matthias-adr/bizzite)

### Opinionated Bazzite image with Niri and DankMaterialShell

This image is built on top of [Bazzite](https://bazzite.gg) and aims to provide [Niri](https://github.com/YaLTeR/niri) and [DMS](https://github.com/AvengeMedia/DankMaterialShell), while using Bazzite-DX-NVIDIA.

## Purpose

The Containerfile is built directly off of [`bazzite-dx-nvidia-gnome:latest`](https://github.com/orgs/ublue-os/packages/container/package/bazzite-dx-nvidia-gnome)

This is my personal image and changes rapidly. 

If you want something designed for general consumption, I suggest using [Zirconium](https://github.com/zirconium-dev/zirconium), Bluefin from [Project Bluefin](https://projectbluefin.io), or [Bazzite](https://bazzite.gg)

## Usage

Oh well. On Bluefin or Bazzite with GNOME, type `sudo bootc switch ghcr.io/matthias-adr/bizzite`.
This is not intended for general use and may break any time though, be warned.

*Notes:* 
- *On first time setup, please press Ctrl + Alt + F3, login in the TTY and then type `sudo dms-greeter --command niri`. After that, type reboot, and you should be good to go.*
- You must navigate to `/etc/niri/config.kdl` and copy its contents, and then paste it into `~/.config/niri/config.kdl` (create one if missing)
- I heavily recommend adding `QT_QPA_PLATFORMTHEME=qt6ct` to /etc/environment

## Credits

The folks over at Fedora and Project Bluefin are wonderful people. :D

Many parts of Bizzite use parts of Zirconium made by [Tulip](https://github.com/tulilirockz) and [Valerie](https://github.com/valerie-tar-gz).

#### _In development. No warranty._

Also, pibble! 🩷💜💙
