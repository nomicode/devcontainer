# Use the latest Debian release
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye as base

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH=$HOME/.local/bin:$SYS_PATH

ENV BREW_BIN=/home/linuxbrew/.linuxbrew/bin
ENV BREW_SBIN=/home/linuxbrew/.linuxbrew/sbin
ENV PATH=$BREW_SBIN:$BREW_BIN:$PATH

ENV GOPATH=${HOME}/.local/go
ENV GOBIN=${HOME}/.local/bin

COPY . $HOME/.devcontainer
WORKDIR $HOME/devcontainer
RUN ./build.sh
