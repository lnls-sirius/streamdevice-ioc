#!/bin/bash
source utils/functions
export PATH=/opt/procServ:$PATH 

export BASE_PROCSERV_PORT=20400


# Agilent 4UHV
export TOP=/opt/stream-ioc
export CMD_KEY="UHV-"
pushd agilent4uhv/server
	export HOME_DIR=${PWD}
	run_ioc
popd

# MKS 937b
export TOP=/opt/stream-ioc
export CMD_KEY="MKS-"
pushd mks937b/server
	export HOME_DIR=${PWD}
	run_ioc
popd

# MBTemp
export TOP=/opt/stream-ioc
export CMD_KEY="MBTemp-"
pushd mbtemp/server
	export HOME_DIR=${PWD}
	run_ioc
popd
