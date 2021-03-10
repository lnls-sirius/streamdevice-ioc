#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from string import Template

rackmonitor_template_top = Template(
    """#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file
cd $(TOP)
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

# Rack Monitoring Board
drvAsynIPPortConfigure("${IP_ASYN_PORT}","${IP_ADDR}", 0, 0, 0)

"""
)

rackmonitor_template = Template(
    """
# Record for configuration of Rack Monitoring Board
dbLoadRecords("db/rackMonitoring.db", "PREFIX = ${PREFIX}, PORT = ${IP_ASYN_PORT}, SCAN_RATE = ${SCAN_RATE}")
"""
)

rackmonitor_template_bot = Template(
    """
# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2
"""
)
