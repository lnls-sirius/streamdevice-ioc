DOCKER_REGISTRY ?= docker.io
DOCKER_USER_GROUP ?= lnlscon
DOCKER_IMAGE_PREFIX = $(DOCKER_REGISTRY)/$(DOCKER_USER_GROUP)

EPICS_BASE_IMAGE ?= $(DOCKER_IMAGE_PREFIX)/epics-debian9-r3.15.8
STREAM_BASE_IMAGE ?= $(DOCKER_IMAGE_PREFIX)/streamdevice-ioc

DATE = $(shell date -I)
COMMIT = $(shell git rev-parse --short HEAD)

EPICS_BASE_TAG ?= $(DATE)
STREAM_BASE_TAG ?= stream-$(DATE)

AGILENT4UHV_TAG ?= Agilent4UHV-$(DATE)
COUNTINGPRU_TAG ?= CountingPRU-$(DATE)
MBTEMP_TAG ?= MBTemp-$(DATE)
MKS937B_TAG ?= MKS937b-$(DATE)
RACKMON_TAG ?= RackMonitoring-$(DATE)
SPIXCONV_TAG ?= SPIxCONV-$(DATE)

BUILD_ENVS += EPICS_BASE_IMAGE=$(EPICS_BASE_IMAGE)
BUILD_ENVS += STREAM_BASE_IMAGE=$(STREAM_BASE_IMAGE)
BUILD_ENVS += EPICS_BASE_TAG=$(EPICS_BASE_TAG)
BUILD_ENVS += STREAM_BASE_TAG=$(STREAM_BASE_TAG)
BUILD_ENVS += AGILENT4UHV_TAG=$(AGILENT4UHV_TAG)
BUILD_ENVS += COUNTINGPRU_TAG=$(COUNTINGPRU_TAG)
BUILD_ENVS += MBTEMP_TAG=$(MBTEMP_TAG)
BUILD_ENVS += MKS937B_TAG=$(MKS937B_TAG)
BUILD_ENVS += RACKMON_TAG=$(RACKMON_TAG)
BUILD_ENVS += SPIXCONV_TAG=$(SPIXCONV_TAG)
BUILD_ENVS += COMMIT_HASH=$(COMMIT)

build: update-env
	docker-compose build

push-all:\
	push-base push-stream push-agilent push-countingpru push-mbtemp push-mks937b push-rackmon push-spixconv
push-base:
	docker push $(EPICS_BASE_IMAGE):$(EPICS_BASE_TAG)
push-stream:
	docker push $(STREAM_BASE_IMAGE):$(STREAM_BASE_TAG)
push-agilent:
	docker push $(STREAM_BASE_IMAGE):$(AGILENT4UHV_TAG)
push-countingpru:
	docker push $(STREAM_BASE_IMAGE):$(COUNTINGPRU_TAG)
push-mbtemp:
	docker push $(STREAM_BASE_IMAGE):$(MBTEMP_TAG)
push-mks937b:
	docker push $(STREAM_BASE_IMAGE):$(MKS937B_TAG)
push-rackmon:
	docker push $(STREAM_BASE_IMAGE):$(RACKMON_TAG)
push-spixconv:
	docker push $(STREAM_BASE_IMAGE):$(SPIXCONV_TAG)

update-env:
	@ > .env
	@ $(foreach var,$(BUILD_ENVS),echo $(var)>>.env;)
