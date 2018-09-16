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

# Bind to socat
drvAsynIPPortConfigure("IPPort0","10.0.6.67:4161", 100, 0, 0)

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 1,  ADDRESS = 001")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 3,  ADDRESS = 001")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC1,  ADDRESS = 001")

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC2, ADDRESS = 002, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC2,  CHANNEL = 1,  ADDRESS = 002")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC2,  CHANNEL = 3,  ADDRESS = 002")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC2,  ADDRESS = 002")

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC3, ADDRESS = 003, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC3,  CHANNEL = 1,  ADDRESS = 003")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC3,  CHANNEL = 3,  ADDRESS = 003")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC3,  ADDRESS = 003")

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, SCAN_RATE = .1 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC4, ADDRESS = 004, CHANNEL = 6, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC4,  CHANNEL = 1,  ADDRESS = 004")
dbLoadRecords("database/mks937b_cc.db", "PORT = IPPort0,  DEVICE = VGC4,  CHANNEL = 3,  ADDRESS = 004")
dbLoadRecords("database/mks937b_relay.db", "PORT = IPPort0,  DEVICE = VGC4,  ADDRESS = 004")


# Effectively initializes the IOC
cd iocBoot
iocInit
