#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Michael Melchers
# Date      :   2023-12-29
##################################################################################################################

echo "---------------"
echo "Install kubectl"
echo "---------------"

yay -S --noconfirm kubectl

echo "---------------"
echo "Install kubectx"
echo "---------------"

yay -S --noconfirm kubectx

echo "-----------------"
echo "Install kubecolor"
echo "-----------------"

yay -S --noconfirm kubecolor