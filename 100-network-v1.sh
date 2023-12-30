#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "----------------------"
echo "Install NetworkManager"
echo "----------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed networkmanager network-manager-applet nm-connection-editor

echo "---------------------------------"
echo "Enable the NetworkManager service"
echo "---------------------------------"

sudo systemctl enable NetworkManager -f
sudo systemctl status NetworkManager