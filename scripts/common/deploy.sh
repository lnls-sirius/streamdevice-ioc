#!/bin/sh
set -ex

if [ -z "${PREFIX}" ]; then
    PREFIX=$1
fi

dirs=$(find "./${PREFIX}/ioc" -type d ! -name "__pycache__")
for dir in $dirs; do

done
	cp -v -p ./spixconv/ioc/autosave/*      $(TOP)/autosave
	cp -v -p ./spixconv/ioc/db/*            $(TOP)/db
	cp -v -p ./spixconv/ioc/protocol/*      $(TOP)/protocol
	cp -v -p ./spixconv/ioc/cmd/*           $(TOP)/iocBoot/iocStreamDeviceIOC