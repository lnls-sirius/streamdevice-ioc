#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from string import Template

rackmonitor_template_top = Template('''#!../bin/linux-x86_64/streamApp

# Environment variables

epicsEnvSet("EPICS_BASE", "${EPICS_BASE}")
epicsEnvSet("ASYN", "${ASYN}")
epicsEnvSet("TOP", "${TOP}")
epicsEnvSet("ARCH", "${ARCH}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "${STREAM_PROTOCOL_PATH}")
epicsEnvSet("EPICS_CA_SERVER_PORT", "${EPICS_CA_SERVER_PORT}")

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")
# Database definition file

cd ${CD}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/log/Security.as")

# Rack Monitoring Board
drvAsynIPPortConfigure("${IP_ASYN_PORT}","${IP_ADDR}", 0, 0, 0)

''')

rackmonitor_template = Template('''
# Record for configuration of Rack Monitoring Board
dbLoadRecords("database/rackMonitoring.db", "PREFIX = ${PREFIX}, PORT = ${IP_ASYN_PORT}, SCAN_RATE = ${SCAN_RATE}")
''')

rackmonitor_template_bot = Template('''
# Effectively initializes the IOC

cd iocBoot
iocInit

caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
''')

