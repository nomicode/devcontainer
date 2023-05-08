#!/bin/bash -e

sudo npm update --global

# Install `shellcheck` and `shfmt` independently from Trunk to avoid VS Code
# extension errors when editing shell scripts outside of a Trunk project or
# before initializing Trunk.

npm install --global \
    shellcheck \
    shfmt \
    trunk
