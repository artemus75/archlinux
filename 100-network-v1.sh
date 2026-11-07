#!/usr/bin/env bash
set -euo pipefail

# NetworkManager is also installed by the base installation guide.
# This script is safe to rerun and never force-replaces another network service.

if (( EUID == 0 )); then
  printf 'Run as a regular user with sudo access, not as root.\n' >&2
  exit 1
fi

sudo pacman -S --needed networkmanager network-manager-applet nm-connection-editor
sudo systemctl enable NetworkManager.service
printf 'NetworkManager is enabled for the next boot.\n'
printf 'Before starting it now, check whether another network manager is active.\n'
