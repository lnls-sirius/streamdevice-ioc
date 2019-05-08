#!/bin/sh
DOCKER_MANTAINER_NAME=lnlscon
DOCKER_NAME=epics-r3.15.5

# The tag pattern :
DOCKER_TAG=asyn3.35_StreamDevice2.8.8
docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}  -f Dockerfile.EPICS .
