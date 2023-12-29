#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

git init
git config --global user.name "Michael Melchers"
git config --global user.email "mmelchers75@gmail.com"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple

echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
