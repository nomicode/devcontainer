#!/bin/sh -e

# Figure out the top directory
script_path="$(realpath "${0}")"
script_dir="$(dirname "${script_path}")"
top_dir="$(realpath "${script_dir}/..")"

# Emulate the Dockerfile build process
set -o allexport
. "${top_dir}/.devcontainer/.env"
sudo rm -rf "${DEVCONTAINER_WORKDIR}"
cd "${script_dir}" && sudo cp -R . "${DEVCONTAINER_WORKDIR}"
cd "${DEVCONTAINER_WORKDIR}" && ./build/run.sh
