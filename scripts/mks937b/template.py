from string import Template

template_top = Template(
    """#!../../bin/linux-x86_64/streamDeviceIOC
# Environment variables
< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file
cd $(TOP)
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

# Bind to socat
drvAsynIPPortConfigure("${IP_ASYN_PORT}","$IP_ADDR", 100, 0, 0)
"""
)

# @todo: terminar de montar esse arquivo template !
template_device = Template(
    """
# General mks937b records
dbLoadRecords("db/mks937b.db", \
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
SCAN_RATE=.1 second")"""
)

template_pressure = Template(
    """
dbLoadRecords("db/mks937b_pressure.db", \
"PORT=$IP_ASYN_PORT, \
D=$D, \
DEVICE=$PREFIX, \
ADDRESS=$ADDRESS, \
CHANNEL=$CHANNEL, \
P_HI=$P_HI, \
P_HIHI=$P_HIHI")"""
)

template_cc = Template(
    """
dbLoadRecords("db/mks937b_cc.db", \
"PORT=$IP_ASYN_PORT, \
DEVICE=$PREFIX, \
CHANNEL=$CHANNEL, \
ADDRESS=$ADDRESS")"""
)

template_relay = Template(
    """
dbLoadRecords("db/mks937b_relay.db", \
"PORT=$IP_ASYN_PORT, \
DEVICE=$PREFIX, \
ADDRESS=$ADDRESS")"""
)


template_bot = Template(
    """

set_requestfile_path("$(TOP)", "autosave")
set_savefile_path("$(TOP)/autosave/save")

# Offsets
set_pass0_restoreFile("$(TOP)/autosave/${name}.sav")
set_pass1_restoreFile("$(TOP)/autosave/${name}.sav")

save_restoreSet_DatedBackupFiles(1)
save_restoreSet_NumSeqFiles(2)
save_restoreSet_SeqPeriodInSeconds(600)

# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

create_monitor_set("${name}.req", 30)
"""
)
