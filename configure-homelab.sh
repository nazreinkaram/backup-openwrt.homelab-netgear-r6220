#!/bin/sh

SHELL_CONFIG_FILE="$(dirname "$0")/.shell.inc.sh"

SHELL_CONFIG_REMOTE_URL="http://gitea.manjeet/manjeet/backup-openwrt.homelab-netgear-r6220/raw/branch/main/.shell.inc.sh"
#
SHELL_CONFIG_TEMP_FILE="/tmp/.shell.inc.sh"

if [ -f "$SHELL_CONFIG_FILE" ]; then
    #
    source "$SHELL_CONFIG_FILE"
    #
else
    printf "\n!!! Shell config file not found, will download !!!\n"
    sleep 2
    printf ".\n"
    printf "DOWNLOADING from "$SHELL_CONFIG_REMOTE_URL".\n"

    curl -s -o "$SHELL_CONFIG_TEMP_FILE" "$SHELL_CONFIG_REMOTE_URL"
    trap "rm -f "$SHELL_CONFIG_TEMP_FILE"; exit 1" 1 2 3 15
    sleep 3

    if [ -f "$SHELL_CONFIG_TEMP_FILE" ]; then
        #
        printf "SAVED shell config file to '$SHELL_CONFIG_TEMP_FILE'\n"
        printf ".\n"
        printf "SOURCING it now...\n"
        sleep 2

        source "$SHELL_CONFIG_TEMP_FILE"

        printf "SOURCED shell config file\n"
        printf ".\n"

        printf "Now DELETING '$SHELL_CONFIG_TEMP_FILE'...\n"
        rm "$SHELL_CONFIG_TEMP_FILE"
        printf ".\n"
        sleep 2
    else
        printf "FAILED to DOWNLOAD shell config file. Exiting...\n"
        printf ".\n"
        exit 1
    fi
fi

_say "PROVIDE Backup Repository URL to restore"
read -p "Enter URL [http(s)]: " GIT_URL

say "Configuring homelab now..."
wait



say "UPDATING package list"
# opkg update
wait
_say "DONE updating package list"

say "INSTALLING necessary packages one by one"
install_package bash
install_package nano-full
install_package git-http
install_package ethtool
install_package iptables-nft
install_package stubby
install_package tailscale
install_package luci-app-nlbwmon
install_package luci-app-wol
install_package ddns-scripts
install_package ddns-scripts-cloudflare
install_package luci-app-acme
_say "DONE installing packages"
wait

say "GOING to: '$WORKING_DIRECTORY'"
cd "$WORKING_DIRECTORY"
sleep 1
_say "Now IN '$WORKING_DIRECTORY'"

say "Now will EXECUTE git STUFF"
_say "DELETING any existing .git directory or temporary git repository"
rm -rf .git "$TEMP_GIT_REPO_NAME"
wait

_say "INITIALIZING new Git repository"
git init
wait

_say "CLONING provided git repository to '$TEMP_GIT_REPO_NAME'"
git clone "$GIT_URL" "$TEMP_GIT_REPO_NAME" >/dev/null 2>&1
GIT_CLONE_EXIT_CODE=$?
wait

if [ "$GIT_CLONE_EXIT_CODE" -eq 0 ]; then

    _say "RESTORING '.git/config' from '$TEMP_GIT_REPO_NAME/.gitrepoconfig'"
    cp "$TEMP_GIT_REPO_NAME/.gitrepoconfig" .git/config
    wait

    _say "REMOVING '$TEMP_GIT_REPO_NAME'"
    rm -rf "$TEMP_GIT_REPO_NAME"
    wait

else

    _say "FAILED to clone git repository from "$GIT_URL", check the URL and try again."

fi


say "DONE!!!"

# # # # # Sync with remote
# # # # git fetch --all
# # # # git reset --hard
# # # # git pull
