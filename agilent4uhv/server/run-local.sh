#!/bin/bash
export BASE_PROCSERV_PORT=20450
export BASE_EPICS_CA_SERVER_PORT=5370

export TOP=/opt/stream-ioc
export HOME_DIR=${PWD}
export CMD_KEY="UHV-"
export PATH=/opt/procServ:$PATH 

source run.sh
