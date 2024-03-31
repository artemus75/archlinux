#!/bin/bash
set -e
#######################################################################################################
# Author        :   Michael Melchers
# Date          :   2023-12-30
#######################################################################################################

package="etcher"

#----------------------------------------------------------------------------------

#checking if application is already installed or else install with yay
if pacman -Qi $package &> /dev/null; then

	echo "---------------------------------------------------------"
	echo "----- "$package" is already installed"
	echo "---------------------------------------------------------"

else

	#checking if yay is already installed
  if pacman -Qi yay &> /dev/null; then

    echo "Installing $package with yay"
    yay -S --noconfirm $package
fi

	# Just checking if installation was successful
	if pacman -Qi $package &> /dev/null; then

	echo "---------------------------------------------------------"
	echo "-----  "$package" has been installed"
	echo "---------------------------------------------------------"

	else

	echo "---------------------------------------------------------"
	echo "-----  "$package" has NOT been installed"
	echo "---------------------------------------------------------"

	fi
fi
