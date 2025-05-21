COMPOSE = docker compose

build: update-env
	make -C ./scripts
	$(COMPOSE) build

update-env:
	./scripts/config.sh

db:
	make -C ./scripts

build-stream:
	$(COMPOSE) build stream

build-mbtemp: build-stream
	$(COMPOSE) build mbtemp

build-mks: build-stream
	$(COMPOSE) build mks937b

push-all: push-base push-stream push-iocs
push-iocs: push-agilent push-countingpru push-mbtemp push-mks937b push-rackmon push-spixconv
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
