#!/bin/sh -ex

# shellcheck source=.devcontainer/build/sh.d/common
. ./build/sh.d/common
print_running "$0"

go install github.com/client9/misspell/cmd/misspell@latest
go install github.com/rif/imgdup2go@latest

go clean --cache
go clean --modcache
