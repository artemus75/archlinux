#!/usr/bin/env bash
set -euo pipefail

# VirtualBox guest only. Do not install host packages inside a guest.
if (( EUID == 0 )); then
  printf 'Run as a regular user with sudo access, not as root.\n' >&2
  exit 1
fi

if ! systemd-detect-virt --quiet --vm || [[ "$(systemd-detect-virt)" != "oracle" ]]; then
  printf 'VirtualBox guest was not detected; refusing to install guest utilities.\n' >&2
  exit 1
fi

sudo pacman -S --needed virtualbox-guest-utils
printf 'Guest utilities installed. Reboot if kernel modules or services require it.\n'
