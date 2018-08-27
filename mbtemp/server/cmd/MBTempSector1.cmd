#!../bin/linux-x86_64/streamApp

# Environment variables

epicsEnvSet("EPICS_BASE", "/opt/epics-R3.15.5/base")
epicsEnvSet("ASYN", "/opt/epics-R3.15.5/modules/asyn4-33")
epicsEnvSet("TOP", "/opt/stream-ioc")
epicsEnvSet("ARCH", "linux-x86_64")
epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(TOP)/protocol")

# Database definition file

cd ${TOP}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)



# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("IPPort0","10.0.6.63:4161", 0, 0, 0)

# Record for configuration of MBTemp exponential moving average smoothing factor

dbLoadRecords("database/MBTemp-Device.db", "MBTEMP_ADDRESS = 8, PORT = IPPort0, PREFIX = MBT1:MBTemp")

# Records corresponding to the eight temperature measurements given by the MBTemp board

dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch1, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch2, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch3, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch4, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch5, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch6, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch7, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 8, PORT = IPPort0, RECORD_NAME = MBT1:MBTemp:Ch8, SCAN_RATE = 2 second")
 


# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("IPPort1","10.0.6.64:4161", 0, 0, 0)

# Record for configuration of MBTemp exponential moving average smoothing factor

dbLoadRecords("database/MBTemp-Device.db", "MBTEMP_ADDRESS = 1, PORT = IPPort1, PREFIX = MBT2:MBTemp")

# Records corresponding to the eight temperature measurements given by the MBTemp board

dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch1, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch2, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch3, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch4, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch5, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch6, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch7, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 1, PORT = IPPort1, RECORD_NAME = MBT2:MBTemp:Ch8, SCAN_RATE = 2 second")
 


# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("IPPort2","10.0.6.65:4161", 0, 0, 0)

# Record for configuration of MBTemp exponential moving average smoothing factor

dbLoadRecords("database/MBTemp-Device.db", "MBTEMP_ADDRESS = 3, PORT = IPPort2, PREFIX = MBT3:MBTemp")

# Records corresponding to the eight temperature measurements given by the MBTemp board

dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch1, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch2, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch3, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch4, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch5, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch6, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch7, SCAN_RATE = 2 second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = 3, PORT = IPPort2, RECORD_NAME = MBT3:MBTemp:Ch8, SCAN_RATE = 2 second")
 

# Effectively initializes the IOC

cd iocBoot
iocInit
