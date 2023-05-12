# Use the latest Debian release
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye as base

ENV BREW_BIN='/home/linuxbrew/.linuxbrew/bin'
ENV BREW_SBIN='/home/linuxbrew/.linuxbrew/sbin'
ENV SYS_PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
ENV PATH="${BREW_SBIN}:${BREW_BIN}:${SYS_PATH}"

COPY . /opt/devcontainer
WORKDIR /opt/devcontainer
RUN run-parts -v --exit-on-error --regex '\.sh$' run.d
