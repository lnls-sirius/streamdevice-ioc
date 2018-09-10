#!../bin/linux-x86_64/streamApp
# Environment variables

epicsEnvSet("EPICS_BASE", "/opt/epics-R3.15.5/base")
epicsEnvSet("ASYN", "/opt/epics-R3.15.5/modules/asyn4-33/")
epicsEnvSet("TOP", "/opt/stream-ioc")
epicsEnvSet("ARCH", "linux-x86_64")
epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(TOP)/protocol")

# Database definition file

cd ${TOP}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

# Bind to socat
drvAsynIPPortConfigure("IPPort0","10.0.6.67:4161", 100, 0, 0)

# General mks937b records
dbLoadRecords("database/mks937b_min.db", "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 1,  ADDRESS = 001")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 3,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 1,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 2,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 3,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 4,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 5,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 6,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 7,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 8,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 9,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 10,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 11,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC1,  RELAY = 12,  ADDRESS = 001")

# General mks937b records
dbLoadRecords("database/mks937b_min.db", "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC2,  CHANNEL = 1,  ADDRESS = 002")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC2,  CHANNEL = 3,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 1,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 2,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 3,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 4,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 5,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 6,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 7,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 8,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 9,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 10,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 11,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC2,  RELAY = 12,  ADDRESS = 002")

# General mks937b records
dbLoadRecords("database/mks937b_min.db", "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC3,  CHANNEL = 1,  ADDRESS = 003")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC3,  CHANNEL = 3,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 1,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 2,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 3,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 4,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 5,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 6,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 7,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 8,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 9,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 10,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 11,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC3,  RELAY = 12,  ADDRESS = 003")

# General mks937b records
dbLoadRecords("database/mks937b_min.db", "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure_min.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC4,  CHANNEL = 1,  ADDRESS = 004")
dbLoadRecords("database/mks937b_cc_min.db", "PORT = IPPort0,  DEVICE = VGC4,  CHANNEL = 3,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 1,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 2,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 3,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 4,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 5,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 6,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 7,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 8,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 9,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 10,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 11,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay_min.db", "PORT = IPPort0,  DEVICE = VGC4,  RELAY = 12,  ADDRESS = 004")


# Effectively initializes the IOC
cd iocBoot
iocInit
