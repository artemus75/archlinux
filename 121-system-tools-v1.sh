#!/usr/bin/env bash
set -euo pipefail

if (( EUID == 0 )); then
  printf 'Run as a regular user with sudo access, not as root.\n' >&2
  exit 1
fi

sudo pacman -S --needed usbutils
