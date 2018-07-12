from string import Template

mbt_template = Template('''#!../bin/linux-x86_64/streamApp

# Environment variables

epicsEnvSet("EPICS_BASE", "$EPICS_BASE")
epicsEnvSet("ASYN", "$ASYN")
epicsEnvSet("TOP", "$TOP")
epicsEnvSet("ARCH", "$ARCH")
epicsEnvSet ("STREAM_PROTOCOL_PATH", "$STREAM_PROTOCOL_PATH")

# Database definition file

cd $CD
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

# MBTemp board (TCP with socat binding the serial port at 115200)
drvAsynIPPortConfigure("$IP_ASYN_PORT_1","$IP_ADDR_1", 0, 0, 0)

# Record for configuration of MBTemp exponential moving average smoothing factor

dbLoadRecords("database/MBTemp-Device.db", "MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, PREFIX_1 = $PREFIX_1")

# Records corresponding to the eight temperature measurements given by the MBTemp board

dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 0, DESCRIPTION = MBTemp Channel 1, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch1, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 1, DESCRIPTION = MBTemp Channel 2, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch2, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 2, DESCRIPTION = MBTemp Channel 3, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch3, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 3, DESCRIPTION = MBTemp Channel 4, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch4, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 4, DESCRIPTION = MBTemp Channel 5, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch5, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 5, DESCRIPTION = MBTemp Channel 6, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch6, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 6, DESCRIPTION = MBTemp Channel 7, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch7, SCAN_RATE = $SCAN_RATE second")
dbLoadRecords("database/MBTemp-Channel.db", "CHANNEL = 7, DESCRIPTION = MBTemp Channel 8, MBTEMP_ADDRESS = $MBTEMP_ADDRESS, PORT = $IP_ASYN_PORT_1, RECORD_NAME = $PREFIX_1:Ch8, SCAN_RATE = $SCAN_RATE second")

# Effectively initializes the IOC

cd iocBoot
iocInit
''')