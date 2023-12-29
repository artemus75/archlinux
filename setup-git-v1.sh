#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

echo "Enter your name: " && read name
echo "Enter your email: " && read email

git init
git config --global user.name "$name"
git config --global user.email "$email"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple

echo "--------------------------------"
echo "----------    Done    ----------"
echo "--------------------------------"
