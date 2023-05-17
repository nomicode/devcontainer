#!/bin/sh -ex

GH_RAW_URL=https://raw.githubusercontent.com
INSTALL_SCRIPT=install.sh
INSTALL_URL="${GH_RAW_URL}/Homebrew/install/HEAD/${INSTALL_SCRIPT}"

# Signal to the Homebrew installer that we can run as root
sudo touch /.dockerenv

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

# Replicate environment variables set in the Dockerfile
BREW_BIN=/home/linuxbrew/.linuxbrew/bin
BREW_SBIN=/home/linuxbrew/.linuxbrew/sbin
PATH="${BREW_SBIN}:${BREW_BIN}:${PATH}"
export PATH

brew update
brew bundle install
brew doctor

brew_cache="$(brew --cache)"
rm -rf "${brew_cache}"
