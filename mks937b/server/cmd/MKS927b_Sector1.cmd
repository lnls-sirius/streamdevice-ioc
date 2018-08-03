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
drvAsynIPPortConfigure("$IP_ASYN_PORT","10.0.6.72:4161", 0, 0, 0)


# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second, CHANNEL = 0, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort0, DEVICE = VGC1, ADDRESS = 001, SCAN_RATE = 10 second, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 1,  ADDRESS = 001,  SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 3,  ADDRESS = 001,  SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort0,  DEVICE = VGC1,  CHANNEL = 5,  ADDRESS = 001,  SCAN_RATE = 10 second")
# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second, CHANNEL = 0, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort1, DEVICE = VGC2, ADDRESS = 002, SCAN_RATE = 10 second, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort1,  DEVICE = VGC2,  CHANNEL = 1,  ADDRESS = 002,  SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort1,  DEVICE = VGC2,  CHANNEL = 3,  ADDRESS = 002,  SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort1,  DEVICE = VGC2,  CHANNEL = 5,  ADDRESS = 002,  SCAN_RATE = 10 second")
# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second, CHANNEL = 0, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second, CHANNEL = 1, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second, CHANNEL = 2, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second, CHANNEL = 3, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second, CHANNEL = 4, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_pressure.db",  "PORT = IPPort2, DEVICE = VGC3, ADDRESS = 003, SCAN_RATE = 10 second, CHANNEL = 5, P_HI = 1e-7, P_HIHI = 1e-5")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort2,  DEVICE = VGC3,  CHANNEL = 1,  ADDRESS = 003,  SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort2,  DEVICE = VGC3,  CHANNEL = 3,  ADDRESS = 003,  SCAN_RATE = 10 second")
dbLoadRecords("database/mks937b_cold_cathode.db", "PORT = IPPort2,  DEVICE = VGC3,  CHANNEL = 5,  ADDRESS = 003,  SCAN_RATE = 10 second")

# Effectively initializes the IOC
cd iocBoot
iocInit
