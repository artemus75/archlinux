#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "-------------------------------------"
echo "Install various file system protocols"
echo "-------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed gvfs gvfs-mtp gvfs-nfs gvfs-smb ntfs-3g exfat-utils f2fs-tools ifuse mtpfs cifs-utils
