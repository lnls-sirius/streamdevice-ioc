TOP ?= ..
AGILENT4UHV_PREFIX ?= UHV
COUNTINGPRU_PREFIX ?= PRU
MBTEMP_PREFIX ?= MBTemp
MKS_PREFIX ?= MKS
RACKMON_PREFIX ?= RackMonitoring
SPIXCONV_PREFIX ?= SPIxCONV

build: clean build-agilent4uhv build-countingpru build-mbtemp build-mks937b build-rackmon build-spixconv
build-agilent4uhv:
	./generate.py --device $(AGILENT4UHV_PREFIX)
build-countingpru:
	./generate.py --device $(COUNTINGPRU_PREFIX)
build-mbtemp:
	./generate.py --device $(MBTEMP_PREFIX)
build-mks937b:
	./generate.py --device $(MKS_PREFIX)
build-rackmon:
	./generate.py --device $(RACKMON_PREFIX)
build-spixconv:
	./generate.py --device $(SPIXCONV_PREFIX) --spreadsheet ./spreadsheet/SPIxCONV.xlsx

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
	mkdir -p ../autosave
	mkdir -p ../db
	mkdir -p ../protocol

deploy-agilent4uhv: deploy-req
	cp -v -p ./agilent4uhv/ioc/autosave/* $(TOP)/autosave
	cp -v -p ./agilent4uhv/ioc/db/*       $(TOP)/db
	cp -v -p ./agilent4uhv/ioc/protocol/* $(TOP)/protocol
	cp -v -p ./agilent4uhv/ioc/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-countingpru: deploy-req
	cp -v -p ./countingpru/ioc/db/*       $(TOP)/db
	cp -v -p ./countingpru/ioc/protocol/* $(TOP)/protocol
	cp -v -p ./countingpru/ioc/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-mbtemp: deploy-req
	cp -v -p ./mbtemp/ioc/db/*       $(TOP)/db
	cp -v -p ./mbtemp/ioc/protocol/* $(TOP)/protocol
	cp -v -p ./mbtemp/ioc/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-mks937b: deploy-req
	cp -v -p ./mks937b/ioc/autosave/* $(TOP)/autosave
	cp -v -p ./mks937b/ioc/db/*       $(TOP)/db
	cp -v -p ./mks937b/ioc/protocol/* $(TOP)/protocol
	cp -v -p ./mks937b/ioc/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-rackmon: deploy-req
	cp -v -p ./rackMonitoring/ioc/db/*       $(TOP)/db
	cp -v -p ./rackMonitoring/ioc/protocol/* $(TOP)/protocol
	cp -v -p ./rackMonitoring/ioc/cmd/*      $(TOP)/iocBoot/iocStreamDeviceIOC

deploy-spixconv: deploy-req
	cp -v -p ./spixconv/ioc/autosave/*      $(TOP)/autosave
	cp -v -p ./spixconv/ioc/db/*            $(TOP)/db
	cp -v -p ./spixconv/ioc/protocol/*      $(TOP)/protocol
	cp -v -p ./spixconv/ioc/cmd/*           $(TOP)/iocBoot/iocStreamDeviceIOC

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
