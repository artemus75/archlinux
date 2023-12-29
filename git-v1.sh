#!/bin/bash
#set -e
##################################################################################################################
# Author 	: 	Michael Melchers
##################################################################################################################

# checking if I have the latest files from github
echo "-------------------------------------"
echo "Checking for newer files online first"
echo "-------------------------------------"

git pull

# Below command will backup everything inside the project folder
git add --all .

# Give a comment to the commit if you want
echo "--------------------------"
echo "Write your commit comment!"
echo "--------------------------"

read input

# Committing to the local repository with a message containing the time details and commit text

git commit -m "$input"

# Push the local files to github

git push -u origin main

echo "-----------------------------------------"
echo "----------    Git Push Done    ----------"
echo "-----------------------------------------"
