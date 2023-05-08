#!/bin/sh -ex

GH_RAW_URL=https://raw.githubusercontent.com
INSTALL_SCRIPT=install.sh
INSTALL_URL="${GH_RAW_URL}/Homebrew/install/HEAD/${INSTALL_SCRIPT}"

# Signal to the Homebrew installer that we can run as root
sudo touch /.dockerenv

tmp_dir="$(mktemp -d)"
clean() { rm -rf "${tmp_dir}"; }
trap clean EXIT

# Run the installation in a subshell to allow us to snap back to the original
# working directory on exit
(
    cd "${tmp_dir}"
    wget -q "${INSTALL_URL}" -O "${INSTALL_SCRIPT}"
    chmod 755 "${INSTALL_SCRIPT}"
    NONINTERACTIVE=false
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
