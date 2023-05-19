#!/bin/sh -ex

# shellcheck source=.devcontainer/build/sh.d/common
. ./build/sh.d/common
print_running "$0"

# Ensure correct permissions of the `/usr/local` directory (so the devcontainer
# `remoteUser` will have write access)
sudo chown -R root:admin /usr/local
