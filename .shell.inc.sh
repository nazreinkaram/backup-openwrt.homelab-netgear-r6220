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
    sleep 5
}

install_package() {
    #
    say "Installing package '$1'..."

    if [ "$(echo "$INSTALLED_PACKAGES_LIST" | grep "$1")" ]; then
        say "Package '$1' is already installed. Skipping..."
    else
        opkg install "$1"

        if [ $? -eq 0 ]; then
            say "Package '$1' has been installed successfully."
        else
            say "Failed to install package '$1'."
            exit 1
        fi
    fi
}
