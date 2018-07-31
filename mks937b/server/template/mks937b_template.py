from string import Template
template_top = Template('''#!../bin/linux-x86_64/streamApp

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

''')

# @todo: terminar de montar esse arquivo template !
template_device = Template('''

# mks937b board (TCP with socat binding the serial port)
drvAsynIPPortConfigure("$IP_ASYN_PORT","$IP_ADDR", 0, 0, 0)

# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = $IP_ASYN_PORT, DEVICE = $PREFIX, SCAN_RATE = $SCAN_RATE second")

''')

template_bot = ('''
# Effectively initializes the IOC

cd iocBoot
iocInit
''')

