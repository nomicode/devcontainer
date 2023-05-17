#!/bin/bash -ex

sudo yarn install --global --prefer-dedupe

sudo yarn cache clean --global --force
