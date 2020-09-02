#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from string import Template

rackmonitor_template_top = Template('''#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

epicsEnvSet("EPICS_CA_SERVER_PORT", "${EPICS_CA_SERVER_PORT}")

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")
# Database definition file

cd ${CD}
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/db/Security.as")

# Rack Monitoring Board
drvAsynIPPortConfigure("${IP_ASYN_PORT}","${IP_ADDR}", 0, 0, 0)

''')

rackmonitor_template = Template('''
# Record for configuration of Rack Monitoring Board
dbLoadRecords("db/rackMonitoring.db", "PREFIX = ${PREFIX}, PORT = ${IP_ASYN_PORT}, SCAN_RATE = ${SCAN_RATE}")
''')

rackmonitor_template_bot = Template('''
# Effectively initializes the IOC

cd iocBoot
iocInit

caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
''')

