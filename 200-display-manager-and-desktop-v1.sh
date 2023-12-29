#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed plasma-desktop plasma plasma-meta
sudo pacman -S --noconfirm --needed sddm sddm-kcm
sudo pacman -S --noconfirm --needed noto-fonts breeze-grub

sudo systemctl enable sddm.service -f
