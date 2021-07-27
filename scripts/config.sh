#!/bin/sh
set -exu

DOCKER_REGISTRY=dockerregistry.lnls-sirius.com.br
DOCKER_USER_GROUP=gaslnlscon
DOCKER_IMAGE_PREFIX=${DOCKER_REGISTRY}/${DOCKER_USER_GROUP}

EPICS_BASE_IMAGE=${DOCKER_IMAGE_PREFIX}/epics-debian9-r3.15.8
STREAM_BASE_IMAGE=${DOCKER_IMAGE_PREFIX}/streamdevice-ioc

AUTHOR="Claudio F. Carneiro <claudiofcarneiro@hotmail.com>"
BRANCH=$(git branch --no-color --show-current)
BUILD_DATE=$(date -I)
BUILD_DATE_RFC339=$(date --rfc-3339=seconds)
COMMIT=$(git rev-parse --short HEAD)
DATE=$(date -I)
DEPARTMENT=GAS
REPOSITORY=$(git remote show origin |grep Fetch|awk '{ print $3 }')

EPICS_BASE_TAG=${DATE}
STREAM_BASE_TAG=stream-${DATE}

AGILENT4UHV_TAG=Agilent4UHV-${DATE}-${COMMIT}
COUNTINGPRU_TAG=CountingPRU-${DATE}-${COMMIT}
MBTEMP_TAG=MBTemp-${DATE}-${COMMIT}
MKS937B_TAG=MKS937b-${DATE}-${COMMIT}
RACKMON_TAG=RackMonitoring-${DATE}-${COMMIT}
SPIXCONV_TAG=SPIxCONV-${DATE}-${COMMIT}

BUILD_ENVS="\
    EPICS_BASE_IMAGE=${EPICS_BASE_IMAGE} \
    STREAM_BASE_IMAGE=${STREAM_BASE_IMAGE} \
    EPICS_BASE_TAG=${EPICS_BASE_TAG} \
    STREAM_BASE_TAG=${STREAM_BASE_TAG} \
    AGILENT4UHV_TAG=${AGILENT4UHV_TAG} \
    COUNTINGPRU_TAG=${COUNTINGPRU_TAG} \
    MBTEMP_TAG=${MBTEMP_TAG} \
    MKS937B_TAG=${MKS937B_TAG} \
    RACKMON_TAG=${RACKMON_TAG} \
    SPIXCONV_TAG=${SPIXCONV_TAG} \
    \
    COMMIT_HASH=${COMMIT} \
    BRANCH=${BRANCH} \
    BUILD_DATE=${BUILD_DATE} \
    DATE=${DATE} \
    DEPARTMENT=${DEPARTMENT} \
    REPOSITORY=${REPOSITORY}"

if [ -f .env ]; then
    > .env
    echo AUTHOR=${AUTHOR} >> .env
    echo BUILD_DATE_RFC339=${BUILD_DATE_RFC339} >> .env
    for var in ${BUILD_ENVS}; do
        echo ${var} >> .env
    done
fi
