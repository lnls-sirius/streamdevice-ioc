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
drvAsynIPPortConfigure("IPPort0","10.128.122.102:5003", 0, 0, 0)


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 1, PORT = IPPort0, PREFIX = LA-MBTemp-01, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-01PT100-Top:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-01PT100-Down:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-MBTemp-01-CH3, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-MBTemp-01-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-MBTemp-01-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-MBTemp-01-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-MBTemp-01-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = LA-MBTemp-01-CH8, SCAN_RATE = 2 second")


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 2, PORT = IPPort0, PREFIX = LA-MBTemp-02, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-03PT100-Top:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-03PT100-Down:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-02PT100-Top:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-02PT100-Down:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-MBTemp-02-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-MBTemp-02-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-MBTemp-02-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = LA-MBTemp-02-CH8, SCAN_RATE = 2 second")


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 3, PORT = IPPort0, PREFIX = LA-MBTemp-03, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-04PT100-Top:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-04PT100-Down:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-MBTemp-03-CH3, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-MBTemp-03-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-MBTemp-03-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-MBTemp-03-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-MBTemp-03-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = LA-MBTemp-03-CH8, SCAN_RATE = 2 second")


# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2
