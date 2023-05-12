#!/bin/sh -ex

GH_RAW_URL=https://raw.githubusercontent.com
INSTALL_URL="${GH_RAW_URL}/Homebrew/install/HEAD/${INSTALL_SCRIPT}"
INSTALL_SCRIPT=install.sh

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

# Get absolute path to script directory
script_path="$(realpath "${0}")"
script_dir="$(dirname "${script_path}")"

# Fix Homebrew owner
"${script_dir}/../fix-homebrew-owner.sh"

brew update
brew bundle
brew doctor
