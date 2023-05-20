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

_say() {
    printf "$1\n"
}

say_(){
    printf "/n$1"
}

wait() {
    sleep 5
}

install_package() {
    #
    if [ "$(echo "$INSTALLED_PACKAGES_LIST" | grep "$1")" ]; then
        _say "Package '$1' is already installed. SKIPPING..."
    else
        opkg install "$1" > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            _say "Package '$1' has been installed successfully."
        else
            _say "Failed to install package '$1'."
            return 1
        fi
    fi

    sleep 1
}
