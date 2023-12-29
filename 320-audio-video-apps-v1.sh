#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "----------------------------"
echo "Install audio and video apps"
echo "----------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed pipewire-pulse pipewire-alsa
sudo pacman -S --nocnnfirm --needed vlc