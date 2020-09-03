#!/usr/bin/env bash
set -e
source common/functions

export BASE_PROCSERV_PORT=
PREFIX=PRU

./common/generate.py --epics-base ${EPICS_BASE} --asyn ${ASYN} --device ${PREFIX} \
    --epics-log-addr ${EPICS_IOC_LOG_INET} --epics-log-port ${EPICS_IOC_LOG_PORT} \
    --epics-caputlog-addr ${EPICS_IOC_CAPUTLOG_INET} --epics-caputlog-port ${EPICS_IOC_CAPUTLOG_PORT} \
    --top ${TOP}

run  ${PREFIX}-
