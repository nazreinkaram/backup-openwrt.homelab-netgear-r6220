#!/bin/bash

# SETTINGS
WORKING_DIRECTORY="/overlay/upper"
BACKUP_FILE_PATH="/tmp/git.config-$(date +%s).backup"

# * NO MORE EDITS BELOW

printf "\nChanging directory to: '$WORKING_DIRECTORY'\n"
cd "$WORKING_DIRECTORY"
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


