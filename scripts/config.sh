#!/bin/sh
set -exu

DOCKER_REGISTRY=ghcr.io
DOCKER_USER_GROUP=lnls-sirius
DOCKER_IMAGE_PREFIX=${DOCKER_REGISTRY}/${DOCKER_USER_GROUP}

STREAM_BASE_IMAGE=${DOCKER_IMAGE_PREFIX}/streamdevice-ioc

AUTHOR="Claudio F. Carneiro <claudiofcarneiro@hotmail.com>"
BRANCH=$(git branch --no-color --show-current)
BUILD_DATE=$(date -I)
BUILD_DATE_RFC339=$(date --rfc-3339=seconds)
COMMIT=$(git rev-parse --short HEAD)
DATE=$(date -I)
DEPARTMENT=GAS
REPOSITORY=$(git remote show origin |grep Fetch|awk '{ print $3 }')

STREAM_BASE_TAG=stream-${DATE}

cat << EOF > .env
# Generic
AUTHOR=${AUTHOR}
BRANCH=${BRANCH}
BUILD_DATE=${BUILD_DATE}
BUILD_DATE_RFC339=${BUILD_DATE_RFC339}
COMMIT_HASH=${COMMIT}
DATE=${DATE}
DEPARTMENT=${DEPARTMENT}

# Stream Device Image
STREAM_BASE_IMAGE=${STREAM_BASE_IMAGE}
STREAM_BASE_TAG=${STREAM_BASE_TAG}
EOF
