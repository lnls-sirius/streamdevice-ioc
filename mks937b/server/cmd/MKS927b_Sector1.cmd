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

# Beagleboneblack IP Address (TCP with socat binding the serial port)
drvAsynIPPortConfigure("IPPort0","10.0.6.43:4161", 0, 0, 0)


# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 0.5 second, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 0.5 second, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 0.5 second, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 0.5 second, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 0.5 second, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 0.5 second, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 1,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 3,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 5,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 1,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 2,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 3,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 4,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 5,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 6,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 7,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 8,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 9,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 10,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 11,  ADDRESS = 001,  SCAN_RATE = 2 second")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 12,  ADDRESS = 001,  SCAN_RATE = 2 second")

# Effectively initializes the IOC
cd iocBoot
iocInit
