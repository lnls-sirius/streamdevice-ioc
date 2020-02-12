#!/usr/bin/env python3
from string import Template
template_top = Template('''#!../bin/linux-x86_64/streamApp
# Agilent-4UHV.cmd

# Serial Address is 129 (0x80) + [0 - 31]

# Environment variables
epicsEnvSet("EPICS_BASE", "$EPICS_BASE")
epicsEnvSet("ASYN", "$ASYN")
epicsEnvSet("TOP",  "$TOP")
epicsEnvSet("ARCH", "$ARCH")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$STREAM_PROTOCOL_PATH")
epicsEnvSet("EPICS_CA_SERVER_PORT", "$EPICS_CA_SERVER_PORT")

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")

# Database definition file
cd $CD
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/log/Security.as")

# Bind to socat
drvAsynIPPortConfigure("$IP_ASYN_PORT","$IP_ADDR", 100, 0, 0)
''')

template_sync = Template('''
# Sync Readings
''')

template_device = Template(
'''
# Device ${DEVICE_NUM}
dbLoadRecords("database/Agilent-4UHV-Device.db",  "PORT = ${IP_ASYN_PORT}, PREFIX = ${PREFIX}, PREFIX_CH1 = ${PREFIX_CH1}, PREFIX_CH2 = ${PREFIX_CH2}, PREFIX_CH3 = ${PREFIX_CH3}, PREFIX_CH4 = ${PREFIX_CH4}, SERIAL_ADDRESS = ${SERIAL_ADDRESS}")
''')

template_channel = Template(
'''dbLoadRecords("database/Agilent-4UHV-Channel.db", "PORT=${IP_ASYN_PORT}, PREFIX=${PREFIX}, CHANNEL_NUMBER=${CHANNEL_NUMBER}, SERIAL_ADDRESS=${SERIAL_ADDRESS}, P_HIGH=${P_HIGH}, P_HIHI=${P_HIHI}")
''')

template_bot = Template('''

# Effectively initializes the IOC
cd iocBoot
iocInit
caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
# var streamDebug 1
''')

