#!/usr/bin/env bash
set -e
source common/functions

export BASE_PROCSERV_PORT=20700
PREFIX=MBTemp-

./mbtemp/generate.py --epics-base ${EPICS_BASE} --asyn ${ASYN} --cmd-prefix ${PREFIX} \
    --epics-log-addr ${EPICS_IOC_LOG_INET} --epics-log-port ${EPICS_IOC_LOG_PORT} \
    --top ${TOP} ${EPICS_CA_PORT_INCREASE} ${BASE_EPICS_CA_PORT}
run  ${PREFIX}
