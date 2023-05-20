#!/bin/bash

# SETTINGS
WORKING_DIRECTORY="/overlay/upper"

# Make all git commands executable
chmod +x "$WORKING_DIRECTORY/git-*.sh"

# Change directory to working directory
printf "\nChanging directory to: '$WORKING_DIRECTORY'\n"
cd "$WORKING_DIRECTORY"
sleep 1

printf "\nCopying .git/config to .gitrepoconfig\n"
cp .git/config .gitrepoconfig
sleep 1

printf "\nRolling changes to remote\n"
git add -A
git commit -m "auto commit by openwrt.homelab"
git push

printf "\nDONE!!!\n"
