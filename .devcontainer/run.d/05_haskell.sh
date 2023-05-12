#!/bin/sh -ex

BROK_URL=https://github.com/smallhadroncollider/brok
RELEASES_URL="${BROK_URL}/releases/download"
VERSION=1.1.0
DOWNLOAD_FILE="brok-${VERSION}_x86-64-linux.tar.gz"
DOWNLOAD_URL="${RELEASES_URL}/${VERSION}/${DOWNLOAD_FILE}"
BIN_SCRIPT=brok

tmp_dir="$(mktemp -d)"
clean() { rm -rf "${tmp_dir}"; }
trap clean EXIT

(
    cd "${tmp_dir}"
    wget -q "${DOWNLOAD_URL}" -O "${DOWNLOAD_FILE}"
    tar -xvzf "${DOWNLOAD_FILE}"
    chmod 755 "${BIN_SCRIPT}"
    sudo mv "${BIN_SCRIPT}" /usr/local/bin
)
