#!/bin/sh -ex

# Update content
# ============================================================================

# Run whenever the contents of the workspace mount are updated
# https://containers.dev/implementors/json_reference/#lifecycle-scripts

# Print help if no argument is provided
workspace_dir="${1}"
if test -z "${workspace_dir}"; then
    echo "Usage: ${0} WORKSPACE_DIR" >&2
    exit 1
fi

whoami="$(whoami)"

# Fix workspace umask
# ----------------------------------------------------------------------------

# After applying the changes below, the current user's default umask will
# be respected for all files in the workspace directory

# Change the ownership of the workspace directory and its contents to the
# current user
sudo chown -R "${whoami}" "${workspace_dir}"
# Remove all extended ACL entries (preserved by Docker during mount)
sudo setfacl -bnR "${workspace_dir}"

# Fix Homebrew ownership
# ----------------------------------------------------------------------------

./fix-homebrew-owner.sh

# Allow direnv
# ----------------------------------------------------------------------------

# The `PATH` variable set in Dockerfile should be picked up when image is built
# and used as devcontainer (but it seems this is not the case)
echo "${PATH}"

# Test whether `direnv` is on the PATH
if command -v direnv; then
    # Allow direnv to load `.envrc` files in the workspace mount
    direnv allow "${workspace_dir}"
fi
