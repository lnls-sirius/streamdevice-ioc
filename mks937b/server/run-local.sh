#!/bin/bash
export BASE_PROCSERV_PORT=20400
export BASE_EPICS_CA_SERVER_PORT=5470

export TOP=/opt/stream-ioc
export HOME_DIR=${PWD}
export CMD_KEY=MKS-
export PATH=/opt/procServ:$PATH

source run.sh
