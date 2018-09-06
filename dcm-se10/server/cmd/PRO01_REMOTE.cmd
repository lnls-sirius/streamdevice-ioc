#!../bin/linux-x86_64/streamApp

# Environment variables

epicsEnvSet("EPICS_BASE", "/opt/epics-R3.15.5/base")
epicsEnvSet("ASYN", "/opt/epics-R3.15.5/modules/asyn4-33")
epicsEnvSet("CALC", "/opt/epics-R3.15.5/modules/synApps/calc-R3-7-1")
epicsEnvSet("TOP", "/opt/stream-ioc")
epicsEnvSet("ARCH", "linux-x86_64")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/protocol")

# Database definition file
cd ${TOP}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)


# MBTemp board (with socat binding the serial port at 115200)
drvAsynIPPortConfigure("IPPort1","10.0.7.81:4161", 0, 0, 0)

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch1, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch2, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch3, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch4, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch5, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch6, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch7, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = TEST:MBTemp:Ch8, SCAN_RATE = 2 second")

# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("database/MBTemp-Device.db", "MBTEMP_ADDRESS = 1, PORT = IPPort1, PREFIX = TEST:MBTemp")
 
# Port for the DCM SE-10 device
drvAsynIPPortConfigure("IPPort2", "127.0.0.1:17001 UDP")

# Records of the DCM SE-10 device
dbLoadRecords("database/DCM-SE10.db", "PORT = IPPort2, PREFIX = PRO:DCM_SE-10, SCAN_RATE = 2 second")

# Effectively initializes the IOC

cd iocBoot
iocInit
