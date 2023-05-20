#!/bin/bash

# Directory where this script resides
SCRIPT_DIR="$(dirname "$0")"

# File path to be used as backup
BACKUP_FILE_PATH="/tmp/git.config-$(date +%s).backup"

# * NO MORE EDITS BELOW

printf "\nChanging directory to: '$SCRIPT_DIR'\n"
cd "$SCRIPT_DIR"
sleep 1

printf "Creating backup at '$BACKUP_FILE_PATH'\n"
cp .git/config "$BACKUP_FILE_PATH"
sleep 1

printf "Removing existing Git repository\n"
rm -rf .git
sleep 1

printf "Initializing new Git repository\n"
git init
sleep 1

printf "Restoring backup from '$BACKUP_FILE_PATH' to '.git/config'\n"
cp "$BACKUP_FILE_PATH" .git/config
sleep 1

printf "Adding first commit commit\n"
git add -A
git commit -m "auto commit by git-reinit script"

printf "Git repository has been reinitialized.\n\n"


