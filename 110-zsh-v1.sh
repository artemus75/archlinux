#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "-----------"
echo "Install ZSH"
echo "-----------"

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed zsh

echo "-------------------"
echo "Change shell to zsh"
echo "-------------------"

sudo chsh -s /bin/zsh michael

echo "-----------------"
echo "Install Oh-my-zsh"
echo "-----------------"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"