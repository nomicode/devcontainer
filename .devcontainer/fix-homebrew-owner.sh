#!/bin/sh -ex

# Fix Homebrew ownership
# =============================================================================

# Allow the current user to make changes to Homebrew by changing ownership of
# the `HOMEBREW_PREFIX` directory and its contents to the current user

if test -z "${HOMEBREW_PREFIX:=}"; then
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

whoami="$(whoami)"

sudo chown -R "${whoami}" "${HOMEBREW_PREFIX}"
