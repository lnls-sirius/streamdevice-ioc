#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

# Septum - Booster Ejection Thin
# This script will be used for SPIxCONV installations alongside with EPP hardware and power supplies.

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file
cd $(TOP)

dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

#==========================================================================
#                                       --prefix--
# Kicker:
#  - Ejection Kicker:                BO-48D:PU-EjeKckr
#  - Injection Kicker:               BO-01D:PU-InjKckr
#  - Injection Dipolar Kicker:       SI-01SA:PU-InjDpKckr
#  - Injection Non-Linear Kicker:    SI-01SA:PU-InjNLKckr
#
# Pinger:
#  - Vertical Pinger:                SI-19C4:PU-PingV
#
#  - Septum:
#  - Injection Septum:               TB-04:PU-InjSept
#  - Ejection Thick Septum:          TS-01:PU-EjeSeptG
#  - Ejection Thin Septum:           TS-01:PU-EjeSeptF
#  - Injection Thick Septum:         TS-04:PU-InjSeptG-1
#                                    TS-04:PU-InjSeptG-2
#  - Injection Thin Septum:          TS-04:PU-InjSeptF
#
#==========================================================================
drvAsynIPPortConfigure("socket_spixconv", "10.128.180.108:5005")

# database for 10 kV Voltage source:
dbLoadRecords("db/SPIxCONV_septum.db", "PREFIX=TS-01:PU-EjeSeptF, SCAN_RATE=.1 second, SPIxCONV_ADDRESS=9, VOLTAGE_FACTOR=100, STEP_DELAY=1, STEP_TRIGGER=200")
dbLoadRecords("db/SPIxCONV_Config.db", "P=TS-01:PU-EjeSeptF")

# set_pass0_restoreFile("$(TOP)/autosave/save/TS-01:PU-EjeSeptF.sav")
# set_pass1_restoreFile("$(TOP)/autosave/save/TS-01:PU-EjeSeptF.sav")

# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

cd ..
# create_monitor_set("$(TOP)/autosave/spixconv.req", 10, "P=TS-01:PU-EjeSeptF, SAVENAMEPV=TS-01:PU-EjeSeptF:SaveName")
