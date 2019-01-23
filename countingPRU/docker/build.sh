#!/bin/sh
. ./conf-env.sh
docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG} .