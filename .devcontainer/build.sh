#!/bin/sh -e

run-parts -v --exit-on-error --regex '\.sh$' run.d
