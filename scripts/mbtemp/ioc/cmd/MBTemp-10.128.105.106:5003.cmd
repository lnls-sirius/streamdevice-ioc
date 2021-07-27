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
drvAsynIPPortConfigure("IPPort0","10.128.105.106:5003", 0, 0, 0)


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 1, PORT = IPPort0, PREFIX = BO-MBTemp-11, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-12U:VA-PT100-BG:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-12U:VA-PT100-MD:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-12U:VA-PT100-ED:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-MBTemp-11-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-MBTemp-11-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-MBTemp-11-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-MBTemp-11-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 1, PORT = IPPort0, RECORD_NAME = BO-MBTemp-11-CH8, SCAN_RATE = 2 second")


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 2, PORT = IPPort0, PREFIX = BO-MBTemp-12, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-13U:VA-PT100-BG:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-13U:VA-PT100-MD:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-13U:VA-PT100-ED:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-MBTemp-12-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-MBTemp-12-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-MBTemp-12-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-MBTemp-12-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 2, PORT = IPPort0, RECORD_NAME = BO-MBTemp-12-CH8, SCAN_RATE = 2 second")


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 3, PORT = IPPort0, PREFIX = BO-MBTemp-13, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-14U:VA-PT100-BG:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-14U:VA-PT100-MD:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-14U:VA-PT100-ED:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-MBTemp-13-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-MBTemp-13-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-MBTemp-13-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-MBTemp-13-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 3, PORT = IPPort0, RECORD_NAME = BO-MBTemp-13-CH8, SCAN_RATE = 2 second")


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 4, PORT = IPPort0, PREFIX = BO-MBTemp-14, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-15U:VA-PT100-BG:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-15U:VA-PT100-MD:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-15U:VA-PT100-ED:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-MBTemp-14-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-MBTemp-14-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-MBTemp-14-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-MBTemp-14-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 4, PORT = IPPort0, RECORD_NAME = BO-MBTemp-14-CH8, SCAN_RATE = 2 second")


# Record for configuration of MBTemp exponential moving average smoothing factor
dbLoadRecords("db/MBTemp-Device.db", "MBTEMP_ADDRESS = 5, PORT = IPPort0, PREFIX = BO-MBTemp-15, SCAN_RATE = 10 second")

# Records corresponding to the eight temperature measurements given by the MBTemp board
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-16U:VA-PT100-BG:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-16U:VA-PT100-MD:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-16U:VA-PT100-ED:Temp-Mon, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-MBTemp-15-CH4, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-MBTemp-15-CH5, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-MBTemp-15-CH6, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-MBTemp-15-CH7, SCAN_RATE = 2 second")
dbLoadRecords("db/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 5, PORT = IPPort0, RECORD_NAME = BO-MBTemp-15-CH8, SCAN_RATE = 2 second")


# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2
