#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "Install NetworkManager"
echo "----------------------"
sudo pacman -Syyu
sudo pacman -S --noconfirm --needed networkmanager network-manager-applet nm-connection-editor

echo "Enable the NetworkManager service"
echo "---------------------------------"
sudo systemctl enable NetworkManager -f
