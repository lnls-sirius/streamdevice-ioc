#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from string import Template

mbt_template_top = Template('''#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths
epicsEnvSet("EPICS_CA_SERVER_PORT", "${EPICS_CA_SERVER_PORT}")

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")
# Database definition file

cd ${CD}
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/db/Security.as")

# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("${IP_ASYN_PORT}","${IP_ADDR}", 0, 0, 0)

''')

mbt_template = Template('''
# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = ${MBTEMP_ADDRESS}, PORT = ${IP_ASYN_PORT}, PREFIX = ${PREFIX}, SCAN_RATE = $SCAN_RATE_DEVICE")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH1, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH2, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH3, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH4, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH5, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH6, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH7, SCAN_RATE = $SCAN_RATE")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = ${IP_ASYN_PORT}, RECORD_NAME = $CH8, SCAN_RATE = $SCAN_RATE")

''')

mbt_template_bot = Template('''
# Effectively initializes the IOC

cd iocBoot
iocInit

caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
''')

