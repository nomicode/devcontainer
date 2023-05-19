#!/bin/sh -ex

# shellcheck source=.devcontainer/build/sh.d/common
. ./build/sh.d/common
print_running "$0"

apt_install \
    acl \
    build-essential \
    cronic \
    file \
    gcc
