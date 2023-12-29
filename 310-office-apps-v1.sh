#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "Install office and productivity apps"
echo "------------------------------------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed thunderbird thunderbird-i18n-de libreoffice-fresh libreoffice-fresh-de hunspell-de
