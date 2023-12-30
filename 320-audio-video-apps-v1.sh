#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "----------------------------"
echo "Install audio and video apps"
echo "----------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed pipewire-pulse pipewire-alsa
sudo pacman -S --noconfirm --needed vlc