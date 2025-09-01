#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date          :       2024-11-13
##################################################################################################################

echo "------------------------------"
echo "Install Warp Terminal         "
echo "------------------------------"

sudo sh -c "echo -e '\n[warpdotdev]\nServer = https://releases.warp.dev/linux/pacman/\$repo/\$arch' >> /etc/pacman.conf"
sudo pacman-key -r "linux-maintainers@warp.dev"
sudo pacman-key --lsign-key "linux-maintainers@warp.dev"
sudo pacman -Syyu
sudo pacman -S --noconfirm --needed warp-terminal
