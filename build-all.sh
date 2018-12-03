#!/bin/bash
source utils/functions

# Agilent 4UHV
export BASE_EPICS_CA_SERVER_PORT=5400
export TOP=/opt/stream-ioc
export CMD_KEY="UHV-"
pushd agilent4uhv/server
	export HOME_DIR=${PWD}
	build
popd

# MKS 937b
export BASE_EPICS_CA_SERVER_PORT=5600
export TOP=/opt/stream-ioc
export CMD_KEY="MKS-"
pushd mks937b/server
	export HOME_DIR=${PWD}
	build
popd

# MBTemp
export BASE_EPICS_CA_SERVER_PORT=5800
export TOP=/opt/stream-ioc
export CMD_KEY="MBTemp-"
pushd mbtemp/server
	export HOME_DIR=${PWD}
	build
popd
