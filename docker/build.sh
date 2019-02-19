#!/bin/sh
# ./conf-env.sh
DOCKER_MANTAINER_NAME=lnlscon
DOCKER_NAME=streamdevice-ioc


# The tag pattern :
# v.major.minor-of-the-day.day.month.year
DOCKER_TAG=v1.0.19.2.2019
docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG} .
