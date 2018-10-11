#!/bin/bash
export BASE_PROCSERV_PORT=20200
export TOP=/opt/stream-ioc
export HOME_DIR=${PWD}
export CMD_KEY=mks
export PATH=/opt/procServ:$PATH
export EPICS_CA_SERVER_PORT=5066

source run.sh
