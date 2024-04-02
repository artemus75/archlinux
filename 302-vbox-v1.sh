#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

# only needed on VBox Virtual Machines

echo "------------------------------"
echo "Install VirtualBox guest utils"
echo "------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed virtualbox
sudo pacman -S --noconfirm --needed virtualbox-guest-utils
sudo pacman -S --noconfirm --needed virtualbox-host-modules-arch
