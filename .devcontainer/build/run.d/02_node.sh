#!/bin/bash -ex

# shellcheck source=.devcontainer/build/sh.d/common
. ./build/sh.d/common
print_running "$0"

NODESOURCE_URL=https://deb.nodesource.com/setup_19.x
NODESOURCE_SCRIPT=nodesource_setup.sh

YARN_DEB_REPO=https://dl.yarnpkg.com/debian
YARN_PUBKEY_URL="${YARN_DEB_REPO}/pubkey.gpg"
YARN_PUBKEY=pubkey.gpg
YARN_KEY_PATH="/usr/share/keyrings/yarnkey.gpg"
YARN_LIST=/etc/apt/sources.list.d/yarn.list

tmp_dir="$(mktemp -d)"
clean() { rm -rf "${tmp_dir}"; }
trap clean EXIT

(
    cd "${tmp_dir}"
    # Set up APT for latest Node.js
    wget -q "${NODESOURCE_URL}" -O "${NODESOURCE_SCRIPT}"
    chmod 755 "${NODESOURCE_SCRIPT}"
    sudo "./${NODESOURCE_SCRIPT}"
    # Set up APT for latest Yarn
    wget -q "${YARN_PUBKEY_URL}" -O "${YARN_PUBKEY}"
    sudo rm -f "${YARN_KEY_PATH}"
    sudo gpg --dearmor --output "${YARN_KEY_PATH}" "${YARN_PUBKEY}"
    echo "deb [signed-by=${YARN_KEY_PATH}] ${YARN_DEB_REPO} stable main" \
        >yarn.list
    sudo mv yarn.list "${YARN_LIST}"
)

apt_install \
    nodejs \
    yarn

sudo yarn install --global --prefer-dedupe

sudo yarn cache clean --global --force
