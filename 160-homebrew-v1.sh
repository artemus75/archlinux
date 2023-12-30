#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "----------------"
echo "Install Homebrew"
echo "----------------"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc

echo "--------------------------------------------------------"
echo "Check installation of Homebrew by displaying the version"
echo "--------------------------------------------------------"

brew --version

echo "----------------"
echo "Install Starship"
echo "----------------"
