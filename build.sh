#!/bin/sh
DOCKER_MANTAINER_NAME=lnlscon
DOCKER_NAME=streamdevice-ioc

# The tag pattern :
DOCKER_TAG=asyn3.35
docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}   .
