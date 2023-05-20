#!/bin/sh

SHELL_CONFIG_FILE="$(dirname "$0")/.shell.inc.sh"

if [ -f "$SHELL_CONFIG_FILE" ]; then
    #
    source "$SHELL_CONFIG_FILE"
    #
else
    printf "\nShell config file not found. Downloading...\n"
    sleep 2

    SHELL_CONFIG_TEMP_FILE="/tmp/.shell.inc.sh"
    #
    SHELL_CONFIG_REMOTE_URL="http://gitea.manjeet/manjeet/backup-openwrt.homelab-netgear-r6220/raw/branch/main/.shell.inc.sh"

    curl -s -o "$SHELL_CONFIG_TEMP_FILE" "$SHELL_CONFIG_REMOTE_URL"

    if [ -f "$SHELL_CONFIG_TEMP_FILE" ]; then
        #
        printf "Downloaded shell config file to '$SHELL_CONFIG_TEMP_FILE'. Sourcing...\n"
        sleep 2

        source "$SHELL_CONFIG_TEMP_FILE"

        printf "Sourced shell config file. Now deleting '$SHELL_CONFIG_TEMP_FILE'...\n"
        rm "$SHELL_CONFIG_TEMP_FILE"
        sleep 2
    else
        printf "Failed to download shell config file. Exiting...\n"
        exit 1
    fi
fi

printf "\n"
read -p "Enter Backup Repository URL [http(s)]: " GIT_URL

say "Started homelab configuration"
wait

say "Changing directory to: '$WORKING_DIRECTORY'"
cd "$WORKING_DIRECTORY"
wait

say "Updating package list"
# opkg update
# wait

say "Installing necessary packages one by one"
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

wait

# say "Deleting any existing .git directory"
# rm -rf .git
# wait

# say "Initializing new Git repository"
# git init
# wait

# say "Cloning provided git repository to '$TEMP_GIT_REPO_NAME'"
# git clone "$GIT_URL" "$TEMP_GIT_REPO_NAME"
# wait

# if [ $? -eq 0 ]; then

#     say "Restoring '.git/config' from '$TEMP_GIT_REPO_NAME.gitrepoconfig'"
#     cp "$TEMP_GIT_REPO_NAME.gitrepoconfig" .git/config
#     wait

#     say "Removing '$TEMP_GIT_REPO_NAME'"
#     rm -rf "$TEMP_GIT_REPO_NAME"
#     wait

# else

#     say "Failed to clone provided git repository. Please check the URL and try again."

# fi

# # # # Sync with remote
# # # git fetch --all
# # # git reset --hard
# # # git pull
