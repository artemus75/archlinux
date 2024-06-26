#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "--------------------------------------"
echo "Install various applications and tools"
echo "--------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed chromium firefox firefox-i18n-de
sudo pacman -S --noconfirm --needed file-roller p7zip zip unzip unrar
sudo pacman -S --noconfirm --needed konsole kate neofetch nano exa
sudo pacman -S --noconfirm --needed curl rsync latte-dock
sudo pacman -S --noconfirm --needed ark p7zip unrar unzip
sudo pacman -S --noconfirm --needed kcalc spectacle localsend
sudo pacman -S --noconfirm --needed npm libfido2 glibc
