# <img width="215" height="106" alt="cooltext494339719767785" src="https://github.com/user-attachments/assets/16a63cb9-44de-484f-9274-9a253efa45d0" />
[![Build container image](https://github.com/Matthias-adR/bifin/actions/workflows/build.yml/badge.svg)](https://github.com/Matthias-adR/bifin/actions/workflows/build.yml) [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/matthias-adr/bifin)

### Opinionated Bluefin image with Niri and DankMaterialShell

This image is built on top of [Bluefin](https://projectbluefin.io) and aims to provide [Niri](https://github.com/YaLTeR/niri) and [DMS](https://github.com/AvengeMedia/DankMaterialShell), while using Bluefin-DX-NVIDIA.

## Purpose

The Containerfile is built directly off of [`bluefin-dx-nvidia-open:latest`](https://github.com/ublue-os/bluefin/pkgs/container/bluefin-dx-nvidia-open)

This is my personal image and changes rapidly. 

If you want something designed for general consumption, I suggest using [Zirconium](https://github.com/zirconium-dev/zirconium) or Bluefin from [Project Bluefin](https://projectbluefin.io).

## Usage

Oh well. On Bluefin or Bazzite with GNOME, type `sudo bootc switch ghcr.io/matthias-adr/bifin`.
This is not intended for general use and may break any time though, be warned.

Niri is not configured by default, you'll need to figure that out in order to automatically start DMS.

## Credits

The folks over at Fedora and Bluefin are wonderful people. :D

Many parts of Bifin use parts of Zirconium made by [Tulip](https://github.com/tulilirockz) and [Valerie](https://github.com/valerie-tar-gz).


---

_In development. No warranty._

Also, pibble! 🩷💜💙
