#!../bin/linux-x86_64/streamApp
# UVX-Agilent-4UHV.cmd

# This script is being used for one of the Agilent 4UHV pumps installed in UVX.
# Serial Address is 128 (0x80) + [0 - 31]
# Environment variables
epicsEnvSet("EPICS_BASE", "/opt/epics-R3.15.5/base")
epicsEnvSet("ASYN", "/opt/epics-R3.15.5/modules/asyn4-33")
epicsEnvSet("TOP", "/opt/stream-ioc")
epicsEnvSet("ARCH", "linux-x86_64")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/protocol")
epicsEnvSet("EPICS_CA_SERVER_PORT", "5072")

# Database definition file
cd ${TOP}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

# RS-485 serial interface (38400 bps)
drvAsynSerialPortConfigure("serialPort1", "/dev/ttyUSB0")
asynSetOption("serialPort1", 0, "baud", "38400")

# Records corresponding to the second Agilet 4UHV device installed in UVX
dbLoadRecords("database/Agilent-4UHV-Device.db", "PORT = serialPort1, PREFIX = Ag, PREFIX-CH1 = Ag:Ch1, PREFIX-CH2 = Ag:Ch2, PREFIX-CH3 = Ag:Ch3, PREFIX-CH4 = Ag:Ch4, SERIAL_ADDRESS = 128")

# Records corresponding to UVX parameter F-ABI09F
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 1, PORT = serialPort1, PREFIX = Ag:Ch1, SERIAL_ADDRESS = 128")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 2, PORT = serialPort1, PREFIX = Ag:Ch2, SERIAL_ADDRESS = 128")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 3, PORT = serialPort1, PREFIX = Ag:Ch3, SERIAL_ADDRESS = 128")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 4, PORT = serialPort1, PREFIX = Ag:Ch4, SERIAL_ADDRESS = 128")

# Effectively initializes the IOC
cd iocBoot
iocInit

