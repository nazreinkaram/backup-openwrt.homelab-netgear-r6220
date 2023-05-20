#!/bin/bash

# SETTINGS
WORKING_DIRECTORY="/overlay/upper"
TEMP_GIT_REPO_DIRECTORY="temp-git-repo"

printf "\nStarted configuring for homelab\n\n"
# Prompt the user for a valid Git URL
read -p "Enter Backup Repository URL [http(s)]: " GIT_URL

printf "\nChanging directory to: '$WORKING_DIRECTORY'\n"
cd "$WORKING_DIRECTORY"
sleep 1

printf "\nUpdating package list\n\n"
opkg update
sleep 1

printf "\nInstalling necessary packages one by one\n"
opkg install bash
opkg install nano-full
opkg install git-http
opkg install ethtool
opkg install iptables-nft
opkg install stubby
opkg install tailscale
opkg install luci-app-nlbwmon
opkg install luci-app-wol
opkg install ddns-scripts
opkg install ddns-scripts-cloudflare
opkg install luci-app-acme

printf "\nDeleting any existing .git directory\n"
rm -rf .git
sleep 1

printf "\nInitializing new git repository\n"
git init
sleep 1

printf "\nCloning provided git repository to '$TEMP_GIT_REPO_DIRECTORY'\n"
git clone "$GIT_URL" "$TEMP_GIT_REPO_DIRECTORY"
sleep 1

printf "\nRestoring '.git/config' from '$TEMP_GIT_REPO_DIRECTORY.gitrepoconfig'\n"
cp .gitrepoconfig .git/config

printf "\nRemoving '$TEMP_GIT_REPO_DIRECTORY'\n"
rm -rf "$TEMP_GIT_REPO_DIRECTORY"

# # Sync with remote
# git fetch --all
# git reset --hard
# git pull
