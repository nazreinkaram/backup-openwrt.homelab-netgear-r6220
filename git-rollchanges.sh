#!/bin/bash

SOURCE "$(dirname "$0")/.shell.inc.sh"

say "GOING TO '$WORKING_DIRECTORY'"
cd "$WORKING_DIRECTORY"
sleep 1
_say "NOW IN '$WORKING_DIRECTORY'"

say "MAKING all 'git-*.sh' scripts executable"
chmod +x "$WORKING_DIRECTORY/git-*.sh"
wait
_say "DONE"

say COPYING '.git/config' to '.gitrepoconfig'
cp .git/config .gitrepoconfig
wait
_say "DONE"

say "COMMITING changes and PUSHING to remote"
git add -A
git commit -m "auto commit by openwrt.homelab"
git push

say "FINISHED"
