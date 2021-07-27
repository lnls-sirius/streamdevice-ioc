#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file
cd $(TOP)
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("IPPort0","10.128.122.101:5003", 0, 0, 0)


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 1, PORT = IPPort0, PREFIX = LTB, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH1, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH2, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH3, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LTB-CH8, SCAN_RATE = 2 second")


# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2
