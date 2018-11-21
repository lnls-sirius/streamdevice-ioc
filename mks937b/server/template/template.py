from string import Template
template_top = Template('''#!../bin/linux-x86_64/streamApp
# Environment variables

epicsEnvSet("EPICS_BASE", "$EPICS_BASE")
epicsEnvSet("ASYN", "$ASYN")
epicsEnvSet("TOP", "$TOP")
epicsEnvSet("ARCH", "$ARCH")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$STREAM_PROTOCOL_PATH")
epicsEnvSet("EPICS_CA_SERVER_PORT", "$EPICS_CA_SERVER_PORT")

# Database definition file

cd $CD
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

# Bind to socat
drvAsynIPPortConfigure("$IP_ASYN_PORT","$IP_ADDR", 100, 0, 0)
''')

# @todo: terminar de montar esse arquivo template !
template_device = Template('''
# General mks937b records
dbLoadRecords("database/mks937b.db", \
"PORT = $IP_ASYN_PORT, \
DEVICE = $PREFIX,\
  G1 = $G1,\
  G2 = $G2,\
  G3 = $G3,\
  G4 = $G4,\
  G5 = $G5,\
  G6 = $G6,\
  ADDRESS = $ADDRESS,\
  MKS_PRESSURES = $MKS_PRESSURES,\
  SCAN_RATE = .1 second")''')

template_pressure = Template('''
dbLoadRecords("database/mks937b_pressure.db", \
 "PORT = $IP_ASYN_PORT,\
  DEVICE = $PREFIX,\
  ADDRESS = $ADDRESS,\
  CHANNEL = $CHANNEL,\
  P_HI = $P_HI,\
  P_HIHI = $P_HIHI")''')

template_cc = Template('''
dbLoadRecords("database/mks937b_cc.db",\
 "PORT = $IP_ASYN_PORT,\
  DEVICE = $PREFIX,\
  CHANNEL = $CHANNEL,\
  ADDRESS = $ADDRESS")''')

template_relay = Template('''
dbLoadRecords("database/mks937b_relay.db",\
 "PORT = $IP_ASYN_PORT,\
  DEVICE = $PREFIX,\
  ADDRESS = $ADDRESS")''')


template_bot = ('''

# Effectively initializes the IOC
cd iocBoot
iocInit
''')

