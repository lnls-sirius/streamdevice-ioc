.PHONY: clean mks 4uhv pru spixconv mbtemp push-all

DOCKER_MANTAINER_NAME=lnlscon
DOCKER_NAME=streamdevice-ioc
DOCKER_TAG=v1.2

clean:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	find . -name '*~'    -exec rm --force {} +
	find . -name '__pycache__'  -exec rm -rd --force {} +

mks:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:MKS-${DOCKER_TAG} -f Dockerfile .

4uhv:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:4UHV-${DOCKER_TAG} -f Dockerfile .

pru:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:PRU-${DOCKER_TAG} -f Dockerfile .

spixconv:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:SPIxCONV-${DOCKER_TAG} -f Dockerfile .

mbtemp:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:MBTemp-${DOCKER_TAG} -f Dockerfile .

base:
	DOCKER_MANTAINER_NAME=lnlscon
	DOCKER_NAME=epics-r3.15.5
	DOCKER_TAG=asyn3.35_StreamDevice2.8.8
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}  -f Dockerfile.EPICS .

push-all:
	docker push ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:MKS-${DOCKER_TAG}
	docker push ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:4UHV-${DOCKER_TAG}
	docker push ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:PRU-${DOCKER_TAG}
	docker push ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:SPIxCONV-${DOCKER_TAG}
	docker push ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:MBTemp-${DOCKER_TAG}

