#!/usr/bin/env bash
set -e
source common/functions

export BASE_PROCSERV_PORT=
PREFIX=UHV

./common/generate.py --device ${PREFIX}

# run ${PREFIX}-
