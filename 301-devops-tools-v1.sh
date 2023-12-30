#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "--------------------------------------"
echo "Install various DevOps and cloud tools"
echo "--------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed terraform vagrant packer helm argocd