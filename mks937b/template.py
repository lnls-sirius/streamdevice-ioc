from string import Template
template_top = Template('''#!../bin/linux-x86_64/streamApp
# Environment variables

epicsEnvSet("EPICS_BASE", "$EPICS_BASE")
epicsEnvSet("ASYN", "$ASYN")
epicsEnvSet("TOP", "$TOP")
epicsEnvSet("ARCH", "$ARCH")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$STREAM_PROTOCOL_PATH")
epicsEnvSet("EPICS_CA_SERVER_PORT", "$EPICS_CA_SERVER_PORT")

epicsEnvSet("EPICS_IOC_LOG_INET", "${LOG_ADDR}")
epicsEnvSet("EPICS_IOC_LOG_PORT", "${LOG_PORT}")

# Database definition file
cd $CD
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)
asSetFilename("${TOP}/log/Security.as")

# Bind to socat
drvAsynIPPortConfigure("${IP_ASYN_PORT}","$IP_ADDR", 100, 0, 0)
''')

# @todo: terminar de montar esse arquivo template !
template_device = Template('''
# General mks937b records
dbLoadRecords("database/mks937b.db", \
"PORT=$IP_ASYN_PORT, \
DEVICE=$PREFIX, \
G1=$G1, \
G2=$G2, \
G3=$G3, \
G4=$G4, \
G5=$G5, \
G6=$G6, \
ADDRESS=$ADDRESS, \
P_PROTO=$P_PROTO, \
SCAN_RATE=.1 second")''')

template_pressure = Template('''
dbLoadRecords("database/mks937b_pressure.db", \
"PORT=$IP_ASYN_PORT, \
D=$D, \
DEVICE=$PREFIX, \
ADDRESS=$ADDRESS, \
CHANNEL=$CHANNEL, \
P_HI=$P_HI, \
P_HIHI=$P_HIHI")''')

template_cc = Template('''
dbLoadRecords("database/mks937b_cc.db", \
"PORT=$IP_ASYN_PORT, \
DEVICE=$PREFIX, \
CHANNEL=$CHANNEL, \
ADDRESS=$ADDRESS")''')

template_relay = Template('''
dbLoadRecords("database/mks937b_relay.db", \
"PORT=$IP_ASYN_PORT, \
DEVICE=$PREFIX, \
ADDRESS=$ADDRESS")''')


template_bot = Template('''
 
# Offsets
set_pass0_restoreFile("$(TOP)/autosave/${name}.sav")
set_pass1_restoreFile("$(TOP)/autosave/${name}.sav")

save_restoreSet_DatedBackupFiles(1)
save_restoreSet_NumSeqFiles(2)
save_restoreSet_SeqPeriodInSeconds(600)

# Effectively initializes the IOC
cd iocBoot
iocInit

cd "$(TOP)"
create_monitor_set("autosave/${name}.req", 10)

caPutLogInit "${CAPUTLOG_ADDR}:${CAPUTLOG_PORT}" 2
''')

