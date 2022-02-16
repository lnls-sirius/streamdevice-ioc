build: build-epics update-env
	make -C ./scripts
	docker-compose build

update-env:
	./scripts/config.sh

db:
	make -C ./scripts

build-epics: update-env
	docker-compose build epics

build-mks: build-epics
	docker-compose build mks937b

build-stream: build-epics
	docker-compose build stream

build-mbtemp: build-stream
	docker-compose build mbtemp

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
