#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "Install various applications and tools"
echo "----------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed chromium firefox firefox-i18n-de
sudo pacman -S --noconfirm --needed file-roller p7zip zip unzip unrar
sudo pacman -S --noconfirm --needed konsole kate neofetch nano exa
sudo pacman -S --noconfirm --needed curl rsync latte-dock