#!/usr/bin/env python3
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

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")

# Database definition file

cd $CD
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/log/Security.as")

# Port for the device
drvAsynIPPortConfigure("${IP_ASYN_PORT}", "${IP}:5000")
''')

template = Template('''

# Record for configuration of TimeBase
dbLoadRecords("database/CountingPRU-Device.db", "PORT = ${IP_ASYN_PORT}, PREFIX = ${COUNTING_DEVICE}, CH1 = ${DETECTOR1_NAME}, CH2 = ${DETECTOR2_NAME}, CH3 = ${DETECTOR3_NAME}, CH4 = ${DETECTOR4_NAME}, CH5 = ${DETECTOR5_NAME}, CH6 = ${DETECTOR6_NAME}, CH7 = ${DETECTOR7_NAME}, CH8 = ${DETECTOR8_NAME}")

# Records corresponding to the eight countings
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 1, DESCRIPTION=${CH1_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH1}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR1_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 2, DESCRIPTION=${CH2_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH2}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR2_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 3, DESCRIPTION=${CH3_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH3}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR3_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 4, DESCRIPTION=${CH4_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH4}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR4_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 5, DESCRIPTION=${CH5_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH5}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR5_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 6, DESCRIPTION=${CH6_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH6}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR6_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 7, DESCRIPTION=${CH7_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH7}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR7_NAME}")
dbLoadRecords("database/CountingPRU-Channel.db", "CHANNEL = 8, DESCRIPTION=${CH8_DESC}, PORT = ${IP_ASYN_PORT}, RECORD_NAME =${CH8}, SCAN_RATE = ${SCAN_RATE}, BOARD_NAME = ${COUNTING_DEVICE}, DETECTOR_NAME = ${DETECTOR8_NAME}")

''')

template_bot = Template('''
# Effectively initializes the IOC

cd iocBoot
iocInit

caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
''')
