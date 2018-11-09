#!../bin/linux-x86_64/streamApp

# Environment variables

epicsEnvSet("EPICS_BASE", "/opt/epics-R3.15.5/base")
epicsEnvSet("ASYN", "/opt/epics-R3.15.5/modules/asyn4-33/")
epicsEnvSet("TOP", "/opt/stream-ioc")
epicsEnvSet("ARCH", "linux-x86_64")
epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(TOP)/protocol")
epicsEnvSet("EPICS_CA_SERVER_PORT", "5572")

# Database definition file

cd ${TOP}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("$IP_ASYN_PORT","10.128.255.10:4161", 0, 0, 0)



# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("database/MBTemp-Device.db", "MBTEMP_ADDRESS = 1, PORT = IPPort, PREFIX = mbt-ltb-booster-1")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch1, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch2, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch3, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch4, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch5, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch6, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch7, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 1, PORT = IPPort, RECORD_NAME = mbt-ltb-booster-1:Ch8, SCAN_RATE = 2 second")
 

# Effectively initializes the IOC

cd iocBoot
iocInit
