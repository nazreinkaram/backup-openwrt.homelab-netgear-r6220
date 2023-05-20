# Variables
# Workiing directory will always be /overlay/upper
WORKING_DIRECTORY="/overlay/upper"

# Temporary git repo name to which remote will be cloned
# and then .gitrepoconfig will be copied to .git/config
TEMP_GIT_REPO_NAME="temp-git-repo"

# List of all installed packages
INSTALLED_PACKAGES_LIST=$(opkg list-installed)

# Functions
# Wrap new line around text
say() {
    printf "\n$1\n"
}

wait() {
    sleep 1
}

install_package() {
    #
    printf "\nInstalling package '$1'...\n"

    if [ "$(echo "$INSTALLED_PACKAGES_LIST" | grep "$1")" ]; then
        printf "Package '$1' is already installed. Skipping...\n"
    else
        opkg install "$1" > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            printf "Package '$1' has been installed successfully.\n"
        else
            printf "Failed to install package '$1'.\n"
            return 1
        fi
    fi

    sleep 1
}
