#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "--------------------------------------"
echo "Install various DevOps and cloud tools"
echo "--------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed terraform vagrant packer helm argocd
yay -S --noconfirm bicep azcopy azure-cli-bin

yay -S --noconfirm storageexplorer azuredatastudio-bin visual-studio-code-bin