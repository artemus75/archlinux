#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

# only needed on VBox Virtual Machines

echo "------------------------------"
echo "Install VirtualBox guest utils"
echo "------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed virtualbox-guest-utils