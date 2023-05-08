# Use the latest Debian release
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye as base

ENV HOMEBREW_INSTALL_FROM_API='true'
ENV BREW_BIN='/home/linuxbrew/.linuxbrew/bin'
ENV BREW_SBIN='/home/linuxbrew/.linuxbrew/sbin'
ENV SYS_PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
ENV PATH="${BREW_SBIN}:${BREW_BIN}:${SYS_PATH}"

COPY . /opt/devcontainer
WORKDIR /opt/devcontainer
RUN ./run.d/00_apt.sh && \
    ./run.d/01_npm.sh && \
    ./run.d/02_homebrew.sh && \
    ./run.d/03_system.sh
