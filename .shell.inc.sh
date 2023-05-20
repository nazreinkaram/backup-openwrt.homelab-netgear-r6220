# Workiing directory will always be /overlay/upper
WORKING_DIRECTORY="/overlay/upper"

# Temporary git repo name to which remote will be cloned 
# and then .gitrepoconfig will be copied to .git/config
TEMP_GIT_REPO_NAME="temp-git-repo"

# Wrap new line around text
say() {
    printf "\n$1\n"
}

wait() {
    sleep 5
}