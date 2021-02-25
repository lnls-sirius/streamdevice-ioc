#!/usr/bin/env python3
from string import Template

template_top = Template(
    """#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

# Serial Address is 128 (0x80) + [0 - 31]
epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file
cd $(TOP)
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

# Bind to socat
drvAsynIPPortConfigure("${IP_ASYN_PORT}","${IP_ADDR}", 100, 0, 0)
"""
)

template_device = Template(
    """
# Device ${DEVICE_NUM}
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=${IP_ASYN_PORT},P=${P},\
P_CH1=${P_CH1},P_CH2=${P_CH2},P_CH3=${P_CH3},P_CH4=${P_CH4},\
E_CH1=${E_CH1},E_CH2=${E_CH2},E_CH3=${E_CH3},E_CH4=${E_CH4},\
ADDR=${ADDR},PHAS=${DEVICE_NUM},TIME=${TIME}")
"""
)

template_channel = Template(
    """dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=${IP_ASYN_PORT}, P=${P},D=${D},CH_NUM=${CH_NUM},ADDR=${ADDR}")
"""
)

template_bot = Template(
    """
set_requestfile_path("$(TOP)", "autosave")
set_savefile_path("$(TOP)/autosave/save")

save_restoreSet_DatedBackupFiles(1)
save_restoreSet_NumSeqFiles(2)
save_restoreSet_SeqPeriodInSeconds(600)

# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2
# var streamDebug 1
"""
)

template_autosave_chrestore = Template(
    """
set_pass0_restoreFile("$(TOP)/autosave/save/${IP_ADDR}.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/${IP_ADDR}.sav")
"""
)
template_autosave_chmonitor = Template(
    """
create_monitor_set("${IP_ADDR}.req", 30)
"""
)
