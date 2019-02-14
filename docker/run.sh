#!/bin/sh
. ./conf-env.sh
echo ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}
docker run -d \
    --network host \
    --name ${CONTAINER_NAME} \
     ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}
