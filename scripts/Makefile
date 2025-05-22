TOP ?= ..
PYTHON ?= /usr/bin/env python3
AGILENT4UHV_PREFIX ?= UHV
COUNTINGPRU_PREFIX ?= PRU
MBTEMP_PREFIX ?= MBTemp
MKS_PREFIX ?= MKS
RACKMON_PREFIX ?= RackMonitoring
SPIXCONV_PREFIX ?= SPIxCONV

build: clean build-agilent4uhv build-countingpru build-mbtemp build-mks937b build-rackmon build-spixconv
build-agilent4uhv:
	$(PYTHON) ./generate.py --device $(AGILENT4UHV_PREFIX)
build-countingpru:
	$(PYTHON) ./generate.py --device $(COUNTINGPRU_PREFIX)
build-mbtemp:
	$(PYTHON) ./generate.py --device $(MBTEMP_PREFIX)
build-mks937b:
	$(PYTHON) ./generate.py --device $(MKS_PREFIX)
build-rackmon:
	$(PYTHON) ./generate.py --device $(RACKMON_PREFIX)
build-spixconv:
	$(PYTHON) ./generate.py --device $(SPIXCONV_PREFIX) --spreadsheet ./spreadsheet/SPIxCONV.xlsx

run-agilent4uhv:
	$(eval PREFIX=$(AGILENT4UHV_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-countingpru:
	$(eval PREFIX=$(COUNTINGPRU_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-mbtemp:
	$(eval PREFIX=$(MBTEMP_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-mks937b:
	$(eval PREFIX=$(MKS_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'
run-rackmon:
	$(eval PREFIX=$(RACKMON_PREFIX))
	bash -c 'set -x; set -e; source common/functions; run $(PREFIX)-'

run-spixconv:
	procServ \
		--logfile - \
		--foreground \
		--chdir "${TOP}/iocBoot/iocStreamDeviceIOC" \
		--name "${IOC_NAME}" \
		"unix:${TOP}/sockets/ioc.sock" \
		"./${IOC_CMD}"

deploy: deploy-agilent4uhv deploy-countingpru deploy-mbtemp deploy-mks937b deploy-rackmon deploy-spixconv

deploy-req:
	mkdir -v -p ../autosave
	mkdir -v -p ../db
	mkdir -v -p ../protocol
	mkdir -v -p ../log
	mkdir -v -p ../sockets

deploy-agilent4uhv: deploy-req
	TOP=$(TOP) ./common/deploy.sh agilent4uhv

deploy-countingpru: deploy-req
	TOP=$(TOP) ./common/deploy.sh countingpru

deploy-mbtemp: deploy-req
	TOP=$(TOP) ./common/deploy.sh mbtemp

deploy-mks937b: deploy-req
	TOP=$(TOP) ./common/deploy.sh mks937b

deploy-rackmon: deploy-req
	TOP=$(TOP) ./common/deploy.sh rackMonitoring

deploy-spixconv: deploy-req
	TOP=$(TOP) ./common/deploy.sh spixconv

clean: clean-build clean-pyc clean-deploy
clean-deploy:
	rm -rfv $(TOP)/iocBoot/iocStreamDeviceIOC/*.cmd

clean-build:
	find -type f -name "*.cmd" -exec rm --verbose {} \;
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
