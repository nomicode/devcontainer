#!/bin/sh -ex

# shellcheck source=.devcontainer/build/sh.d/common
. ./build/sh.d/common
print_running "$0"

# Switch default `root` user shell
sudo sed -i 's,/root:/bin/ash,/root:/bin/bash,' /etc/passwd

# Create the `admin` group (intended for the devcontainer `remoteUser`, to
# provide write access to necessary directories)
sudo groupadd -f admin
