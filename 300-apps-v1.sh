#!/usr/bin/env bash
set -euo pipefail

# KDE-oriented application selection. No full database refresh or unattended approvals.
# Older packages neofetch, exa, latte-dock and p7zip were removed from this list.
sudo pacman -S --needed \
  chromium firefox firefox-i18n-de \
  ark zip unzip unrar \
  konsole kate nano \
  curl rsync \
  kcalc spectacle \
  npm libfido2

# Optional packages such as localsend should be reviewed separately for availability.
