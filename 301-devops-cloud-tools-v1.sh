#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "--------------------------------------"
echo "Install various DevOps and cloud tools"
echo "--------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed terraform vagrant packer helm
yay -S --noconfirm bicep azcopy
curl -L https://aka.ms/InstallAzureCli | bash

yay -S --noconfirm storageexplorer azuredatastudio-bin visual-studio-code-bin