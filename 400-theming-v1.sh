#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "All the theming goes in here"
echo "Pacman installation"

sudo pacman -S arc-gtk-theme --noconfirm --needed
sudo pacman -S variety --noconfirm --needed

echo "All the theming goes in here"
echo "AUR installation"

packer -S sardi-icons --noconfirm --noedit
packer -S sardi-mono-papirus-colora-variations-icons-git  --noconfirm --noedit
#packer -S breeze-snow-cursor-theme --noconfirm --noedit
packer -S xcursor-breeze --noconfirm --noedit

echo "##############################################################"
echo "######################   T H E  E N D   ######################"
echo "##############################################################"