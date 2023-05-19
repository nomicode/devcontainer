# Use the latest Debian release
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye as base

COPY . $DEVCONTAINER_WORKDIR
WORKDIR $DEVCONTAINER_WORKDIR
RUN ./bootstrap.sh && make build
