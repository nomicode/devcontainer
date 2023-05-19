#!/bin/sh -e

# This assigment will fail if the container environment variables are not set
workdir="${DEVCONTAINER_WORKDIR:?}"
cd "${workdir}"

# Build specific environment variables (i.e., we don't want to leak these into
# the final container environment)
DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

run-parts --exit-on-error --regex '\.sh$' ./build/run.d
