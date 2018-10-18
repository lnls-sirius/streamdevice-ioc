#!../bin/linux-x86_64/streamApp
# UVX-Agilent-4UHV.cmd

# This script is being used for one of the Agilent 4UHV pumps installed in UVX.
# Serial Address is 129 (0x80) + [0 - 31]

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

# TCP Comm Interface
#drvAsynIPPortConfigure("serialPort1","10.0.6.67:4161", 100, 0, 0)

drvAsynSerialPortConfigure("serialPort1", "/dev/ttyUSB0")
asynSetOption("serialPort1", 0, "baud", "38400")

# Sync Readings
dbLoadRecords("database/Agilent-4UHV-Sync.db", "PREFIX-D1 = D1, PREFIX-D2 = D2, PREFIX-D3 = D3, PREFIX-D4 = D4")

# Device 1
dbLoadRecords("database/Agilent-4UHV-Device.db", "PORT = serialPort1, PREFIX = D1, PREFIX-CH1 = D1:CH1, PREFIX-CH2 = D1:CH2, PREFIX-CH3 = D1:CH3, PREFIX-CH4 = D1:CH4, SERIAL_ADDRESS = 129")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 1, PORT = serialPort1, PREFIX = D1:CH1, SERIAL_ADDRESS = 129")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 2, PORT = serialPort1, PREFIX = D1:CH2, SERIAL_ADDRESS = 129")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 3, PORT = serialPort1, PREFIX = D1:CH3, SERIAL_ADDRESS = 129")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 4, PORT = serialPort1, PREFIX = D1:CH4, SERIAL_ADDRESS = 129")

# Device 2
dbLoadRecords("database/Agilent-4UHV-Device.db", "PORT = serialPort1, PREFIX = D2, PREFIX-CH1 = D2:CH1, PREFIX-CH2 = D2:CH2, PREFIX-CH3 = D2:CH3, PREFIX-CH4 = D2:CH4, SERIAL_ADDRESS = 130")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 1, PORT = serialPort1, PREFIX = D2:CH1, SERIAL_ADDRESS = 130")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 2, PORT = serialPort1, PREFIX = D2:CH2, SERIAL_ADDRESS = 130")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 3, PORT = serialPort1, PREFIX = D2:CH3, SERIAL_ADDRESS = 130")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 4, PORT = serialPort1, PREFIX = D2:CH4, SERIAL_ADDRESS = 130")

# Device 3
dbLoadRecords("database/Agilent-4UHV-Device.db", "PORT = serialPort1, PREFIX = D3, PREFIX-CH1 = D3:CH1, PREFIX-CH2 = D3:CH2, PREFIX-CH3 = D3:CH3, PREFIX-CH4 = D3:CH4, SERIAL_ADDRESS = 131")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 1, PORT = serialPort1, PREFIX = D3:CH1, SERIAL_ADDRESS = 131")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 2, PORT = serialPort1, PREFIX = D3:CH2, SERIAL_ADDRESS = 131")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 3, PORT = serialPort1, PREFIX = D3:CH3, SERIAL_ADDRESS = 131")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 4, PORT = serialPort1, PREFIX = D3:CH4, SERIAL_ADDRESS = 131")

# Device 4
dbLoadRecords("database/Agilent-4UHV-Device.db", "PORT = serialPort1, PREFIX = D4, PREFIX-CH1 = D4:CH1, PREFIX-CH2 = D4:CH2, PREFIX-CH3 = D4:CH3, PREFIX-CH4 = D4:CH4, SERIAL_ADDRESS = 132")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 1, PORT = serialPort1, PREFIX = D4:CH1, SERIAL_ADDRESS = 132")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 2, PORT = serialPort1, PREFIX = D4:CH2, SERIAL_ADDRESS = 132")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 3, PORT = serialPort1, PREFIX = D4:CH3, SERIAL_ADDRESS = 132")
dbLoadRecords("database/Agilent-4UHV-Channel.db", "CHANNEL_NUMBER = 4, PORT = serialPort1, PREFIX = D4:CH4, SERIAL_ADDRESS = 132")



# Effectively initializes the IOC
cd iocBoot
iocInit
