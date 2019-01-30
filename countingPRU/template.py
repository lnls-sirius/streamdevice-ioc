#!/usr/bin/python3
# -*- coding: utf-8 -*-

from string import Template

template_top = Template('''#!../bin/linux-x86_64/streamApp

# Environment variables
epicsEnvSet("EPICS_BASE", "${EPICS_BASE}")
epicsEnvSet("ASYN", "${ASYN}")
epicsEnvSet("TOP", "${TOP}")
epicsEnvSet("ARCH", "${ARCH}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "${STREAM_PROTOCOL_PATH}")
epicsEnvSet("EPICS_CA_SERVER_PORT", "${EPICS_CA_SERVER_PORT}")

# Database definition file

cd $CD
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

# Port for the device
drvAsynIPPortConfigure("${IP_ASYN_PORT}", "${IP}:5000")
''')

template = Template('''

# Record for configuration of TimeBase
dbLoadRecords("database/CountingPRU-Device.db", "PORT = ${IP_ASYN_PORT}, PREFIX = ${PREFIX}")

# Records corresponding to the eight countings
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 1, DESCRIPTION=${CH1_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH1}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 2, DESCRIPTION=${CH2_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH2}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 3, DESCRIPTION=${CH3_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH3}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 4, DESCRIPTION=${CH4_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH4}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 5, DESCRIPTION=${CH5_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH5}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 6, DESCRIPTION=${CH6_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH6}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 7, DESCRIPTION=${CH7_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH7}, SCAN_RATE = ${SCAN_RATE}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 8, DESCRIPTION=${CH8_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH8}, SCAN_RATE = ${SCAN_RATE}")

''')

template_bot = ('''
# Effectively initializes the IOC

cd iocBoot
iocInit
''')

