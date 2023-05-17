#!/bin/sh -ex

# Replicate environment variables set in the Dockerfile
GOPATH="${HOME}/.local/go"
export GOPATH
GOBIN="${HOME}/.local/bin"
export GOBIN

go install github.com/client9/misspell/cmd/misspell@latest
go install github.com/rif/imgdup2go@latest

go clean --cache
go clean --modcache
