#!/usr/bin/env bash
set -euo pipefail

# Install only the filesystem integrations needed on this machine.
# Package availability must be checked against the current Arch repositories.
sudo pacman -S --needed gvfs gvfs-mtp gvfs-nfs gvfs-smb ntfs-3g exfatprogs f2fs-tools ifuse cifs-utils
