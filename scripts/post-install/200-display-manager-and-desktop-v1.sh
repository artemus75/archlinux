#!/usr/bin/env bash
set -euo pipefail

# KDE Plasma desktop with SDDM. Does not replace an active display manager.
sudo pacman -Syu --needed plasma-meta sddm sddm-kcm noto-fonts

if systemctl is-enabled --quiet display-manager.service; then
  current="$(systemctl show -p FragmentPath --value display-manager.service)"
  printf 'Existing display manager configuration: %s\n' "$current"
  printf 'Not changing the existing display manager automatically.\n'
else
  sudo systemctl enable sddm.service
fi
