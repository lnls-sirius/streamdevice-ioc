#!/usr/bin/env python3
from string import Template
template_top = Template('''#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

# Serial Address is 128 (0x80) + [0 - 31]

epicsEnvSet("EPICS_CA_SERVER_PORT", "$EPICS_CA_SERVER_PORT")

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")

# Database definition file
cd $CD
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/db/Security.as")

# Bind to socat
drvAsynIPPortConfigure("$IP_ASYN_PORT","$IP_ADDR", 100, 0, 0)
''')

template_device = Template(
'''
# Device ${DEVICE_NUM}
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=${IP_ASYN_PORT}, PREFIX=${PREFIX}, PREFIX_CH1=${PREFIX_CH1}, PREFIX_CH2=${PREFIX_CH2}, PREFIX_CH3=${PREFIX_CH3}, PREFIX_CH4=${PREFIX_CH4}, SERIAL_ADDRESS=${SERIAL_ADDRESS}, PHAS=${DEVICE_NUM}, TIME=${TIME}")
''')

template_channel = Template(
'''dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=${IP_ASYN_PORT}, PREFIX=${PREFIX}, CHANNEL_NUMBER=${CHANNEL_NUMBER}, SERIAL_ADDRESS=${SERIAL_ADDRESS}, P_HIGH=${P_HIGH}, P_HIHI=${P_HIHI}")
''')

template_bot = Template('''

# Effectively initializes the IOC
cd iocBoot
iocInit
caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
# var streamDebug 1
''')

