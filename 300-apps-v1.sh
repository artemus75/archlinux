#!/usr/bin/env bash
set -euo pipefail

# KDE-oriented application selection. Use a normal full system upgrade (not forced -Syyu); no unattended approvals.
# Older packages neofetch, exa, latte-dock and p7zip were removed from this list.
sudo pacman -Syu --needed \
  chromium firefox firefox-i18n-de \
  ark zip unzip unrar \
  konsole kate nano \
  curl rsync \
  kcalc spectacle \
  npm libfido2

# Optional packages such as localsend should be reviewed separately for availability.
