#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "------------------------------------"
echo "Install office and productivity apps"
echo "------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed thunderbird thunderbird-i18n-de libreoffice-fresh libreoffice-fresh-de hunspell-de
