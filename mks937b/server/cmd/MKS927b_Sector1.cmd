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



# mks937b board (TCP with socat binding the serial port)
drvAsynIPPortConfigure("IPPort0","10.0.6.63:4161", 0, 0, 0)

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort0, DEVICE = VGC1, SCAN_RATE = 10 second")



# mks937b board (TCP with socat binding the serial port)
drvAsynIPPortConfigure("IPPort1","10.0.6.64:4161", 0, 0, 0)

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort1, DEVICE = VGC2, SCAN_RATE = 10 second")



# mks937b board (TCP with socat binding the serial port)
drvAsynIPPortConfigure("IPPort2","10.0.6.65:4161", 0, 0, 0)

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = IPPort2, DEVICE = VGC3, SCAN_RATE = 10 second")


# Effectively initializes the IOC

cd iocBoot
iocInit
