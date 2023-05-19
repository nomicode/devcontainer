#!/bin/sh -ex

# shellcheck source=.devcontainer/build/sh.d/common
. ./build/sh.d/common
print_running "$0"

GH_RAW_URL=https://raw.githubusercontent.com
INSTALL_SCRIPT=install.sh
INSTALL_URL="${GH_RAW_URL}/Homebrew/install/HEAD/${INSTALL_SCRIPT}"

user_id="$(id -u)"
if test "${user_id}" = 0; then
    # Let Homebrew know it's safe to run as the superuser
    sudo touch /.dockerenv
fi

# This assignment will fail if the container environtment variables are not set
homebrew_prefix="${HOMEBREW_PREFIX:?}"

# Remove any existing Homebrew directory (to ensure a clean install)
sudo rm -rf "${homebrew_prefix}"

tmp_dir="$(mktemp -d)"
clean() { rm -rf "${tmp_dir}"; }
trap clean EXIT

(
    cd "${tmp_dir}"
    wget -q "${INSTALL_URL}" -O "${INSTALL_SCRIPT}"
    chmod 755 "${INSTALL_SCRIPT}"
    HOMEBREW_NO_EMOJI=1
    export HOMEBREW_NO_EMOJI
    NONINTERACTIVE=true
    export NONINTERACTIVE
    HOMEBREW_INSTALL_FROM_API=true
    export HOMEBREW_INSTALL_FROM_API
    "./${INSTALL_SCRIPT}"
)

# Copy the `Brewfile` to the Homebrew home directorys so `Brewfile.lock.json`
# is writeable
cp Brewfile "${homebrew_prefix}/Brewfile"
cd "${homebrew_prefix}"

brew update --quiet
brew bundle install
brew doctor

brew_cache="$(brew --cache)"
rm -rf "${brew_cache}"
