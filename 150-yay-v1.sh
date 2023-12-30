#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "-----------"
echo "Install yay"
echo "-----------"

mkdir ~/AUR
cd ~/AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

echo "---------------------------------------------------"
echo "Check installation of yay by displaying the version"
echo "---------------------------------------------------"

yay --version