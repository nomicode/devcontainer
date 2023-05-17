#!/bin/sh -ex

USE_EMOJI=false
export USE_EMOJI

pipx ensurepath

pipx_install() {
    echo "${@}" | tr ' ' '\0' | xargs -0 -n1 \
        pipx install --system-site-packages --pip-args='--no-cache-dir'
}

pipx_install \
    bandit \
    black \
    flake8 \
    ipython \
    isort \
    mypy \
    pep8 \
    pipenv \
    poetry \
    prospector \
    pylint \
    pyright \
    pyroma \
    reorder-python-imports \
    restructuredtext-lint \
    rstcheck \
    rstfmt \
    sourcery \
    tox \
    virtualenv \
    pydocstyle \
    vulture \
    yapf

pip3 cache purge
