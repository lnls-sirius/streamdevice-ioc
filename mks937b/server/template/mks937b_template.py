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

## Beagleboneblack IP Address (TCP with socat binding the serial port)
#drvAsynIPPortConfigure("$IP_ASYN_PORT","$IP_ADDR", 0, 0, 0)

# Bind to a virtual serial port from socat
drvAsynSerialPortConfigure("$IP_ADDR", "/dev/socatUSB0")
asynSetOption("$IP_ADDR", 0, "baud", "115200")

''')

# @todo: terminar de montar esse arquivo template !
template_device = Template('''
# General mks937b records
dbLoadRecords("database/mks937b.db", "PORT = $IP_ASYN_PORT, DEVICE = $PREFIX, ADDRESS = $ADDRESS, SCAN_RATE = $SCAN_RATE second")''')

template_pressure = Template('''
dbLoadRecords("database/mks937b_pressure.db", \
 "PORT = $IP_ASYN_PORT,\
 DEVICE = $PREFIX,\
 ADDRESS = $ADDRESS,\
 SCAN_RATE = $SCAN_RATE second,\
 CHANNEL = $CHANNEL,\
 P_HI = $P_HI,\
 P_HIHI = $P_HIHI")''')

template_cc = Template('''
dbLoadRecords("database/mks937b_cc.db",\
 "PORT = $IP_ASYN_PORT,\
  DEVICE = $PREFIX,\
  CHANNEL = $CHANNEL,\
  ADDRESS = $ADDRESS,\
  SCAN_RATE = $SCAN_RATE second")''')

template_relay = Template('''
dbLoadRecords("database/mks937b_relay.db",\
 "PORT = $IP_ASYN_PORT,\
  DEVICE = $PREFIX,\
  RELAY = $RELAY,\
  ADDRESS = $ADDRESS,\
  SCAN_RATE = $SCAN_RATE second")''')


template_bot = ('''

# Effectively initializes the IOC
cd iocBoot
iocInit
''')

