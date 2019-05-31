.PHONY: clean mks 4uhv pru spixconv mbtemp

DOCKER_MANTAINER_NAME=lnlscon
DOCKER_NAME=streamdevice-ioc
DOCKER_TAG=v1.0

clean:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	find . -name '*~'    -exec rm --force {} +
	find . -name '__pycache__'  -exec rm -rd --force {} +

mks:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:MKS-${DOCKER_TAG}   .

4uhv:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:4UHV-${DOCKER_TAG}   .

pru:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:PRU-${DOCKER_TAG}   .

spixconv:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:SPIxCONV-${DOCKER_TAG}   .

mbtemp:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:MBTemp-${DOCKER_TAG}   .

base:
	DOCKER_MANTAINER_NAME=lnlscon
	DOCKER_NAME=epics-r3.15.5
	DOCKER_TAG=asyn3.35_StreamDevice2.8.8
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}  -f Dockerfile.EPICS .


