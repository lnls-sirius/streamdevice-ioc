#!/bin/bash 
source ../../utils/functions

export BASE_PROCSERV_PORT=20500
export BASE_EPICS_CA_SERVER_PORT=5570

export TOP=/opt/stream-ioc
export HOME_DIR=${PWD}
export CMD_KEY=MBTemp-
export PATH=/opt/procServ:$PATH

build
run_ioc