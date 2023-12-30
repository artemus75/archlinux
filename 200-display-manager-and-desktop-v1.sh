#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "-------------------------------------------------"
echo "Install KDE Plasma desktop and SDDM login manager"
echo "-------------------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed plasma-desktop plasma plasma-meta
sudo pacman -S --noconfirm --needed sddm sddm-kcm
sudo pacman -S --noconfirm --needed noto-fonts breeze-grub

echo "-----------------------"
echo "Enable the SDDM service"
echo "-----------------------"

sudo systemctl enable sddm.service -f
