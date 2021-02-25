TOP ?= ..
AGILENT4UHV_PREFIX ?= UHV
COUNTINGPRU_PREFIX ?= PRU
MBTEMP_PREFIX ?= MBTemp
MKS_PREFIX ?= MKS

build:
build-agilent4uhv:
	python ./common/generate.py --device $(AGILENT4UHV_PREFIX)
build-countingpru:
	python ./common/generate.py --device $(COUNTINGPRU_PREFIX)
build-mbtemp:
	python ./common/generate.py --device $(MBTEMP_PREFIX)
build-mks:
	python ./common/generate.py --device $(MKS_PREFIX)

run-agilent4uhv:
	$(eval PREFIX=$(AGILENT4UHV_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-countingpru:
	$(eval PREFIX=$(COUNTINGPRU_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-mbtemp:
	$(eval PREFIX=$(MBTEMP_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-mks:
	$(eval PREFIX=$(MKS_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'

deploy-req:
	mkdir -p ../autosave
	mkdir -p ../db
	mkdir -p ../protocol

deploy-agilent4uhv: deploy-req
	cp -v -p ./agilent4uhv/server/autosave/* $(TOP)/autosave
	cp -v -p ./agilent4uhv/server/db/*       $(TOP)/db
	cp -v -p ./agilent4uhv/server/protocol/* $(TOP)/protocol
	cp -v -p ./agilent4uhv/server/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-countingpru: deploy-req
	cp -v -p ./countingpru/server/db/*       $(TOP)/db
	cp -v -p ./countingpru/server/protocol/* $(TOP)/protocol
	cp -v -p ./countingpru/server/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-mbtemp: deploy-req
	cp -v -p ./mbtemp/server/db/*       $(TOP)/db
	cp -v -p ./mbtemp/server/protocol/* $(TOP)/protocol
	cp -v -p ./mbtemp/server/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-mks: deploy-req
	cp -v -p ./mks937b/server/autosave/* $(TOP)/autosave
	cp -v -p ./mks937b/server/db/*       $(TOP)/db
	cp -v -p ./mks937b/server/protocol/* $(TOP)/protocol
	cp -v -p ./mks937b/server/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

clean: clean-build clean-pyc clean-deploy
clean-deploy:
	rm -rfv $(TOP)/iocBoot/iocStreamDeviceIOC/*.cmd

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
