#!/bin/sh -e

# Update content

# Run whenever the contents of the workspace mount are updated
# https://containers.dev/implementors/json_reference/#lifecycle-scripts

# ============================================================================

# This command is always run from the workspace directory
workspace_dir="$(pwd)"

# Fix permissions
# ----------------------------------------------------------------------------

# Get current username
whoami="$(whoami)"
user_id="$(id -u)"

# If not the superuser, add the current user to the `admin` group (alowing
# write acccess to the contents of the `/usr/local` directory)
if test "${user_id}" != 0; then
    usermod -aG admin "${whoami}"
fi

# Fix Homebrew permissions (in case the container was originally built by a
# different user)
homebrew_prefix="$(brew --prefix)"
sudo chown -R "${whoami}" "${homebrew_prefix}"

# Fix workspace umask
# ----------------------------------------------------------------------------

# After applying the changes below, the current user's default umask will
# be respected for all files in the workspace directory

# Change the ownership of the workspace directory and its contents to the
# current user
sudo chown -R "${whoami}" "${workspace_dir}"
# Remove all extended ACL entries (preserved by Docker during mount)
sudo setfacl -bnR "${workspace_dir}"

# Allow direnv
# ----------------------------------------------------------------------------

# The `PATH` variable set in Dockerfile should be picked up when image is built
# and used as devcontainer (but it seems this is not the case)
echo "${PATH}"

envrc_file="${workspace_dir}/.envrc"

# Test for existence of `.envrc` file
if test -f "${envrc_file}"; then
    # Test whether `direnv` is on the PATH
    if command -v direnv; then
        # Allow direnv to load `.envrc` files in the workspace mount
        direnv allow "${workspace_dir}"
    fi
fi
