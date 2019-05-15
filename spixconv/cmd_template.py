#!/usr/bin/python3
from string import Template

top = Template('''#!../bin/linux-x86_64/streamApp

# ${DESCRIPTION}

# This script will be used for SPIxCONV installations alongside with EPP hardware and power supplies.

# Environment variables
epicsEnvSet("EPICS_BASE", "${EPICS_BASE}")
epicsEnvSet("ASYN", "${ASYN}")
epicsEnvSet("TOP", "${TOP}")
epicsEnvSet("ARCH", "${ARCH}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "${STREAM_PROTOCOL_PATH}")
epicsEnvSet("EPICS_CA_SERVER_PORT", "${EPICS_CA_SERVER_PORT}")

# Database definition file
cd ${CD}
dbLoadDatabase("dbd/streamApp.dbd")
streamApp_registerRecordDeviceDriver(pdbbase)

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
drvAsynIPPortConfigure("socket_spixconv", "${IP_ADDR}")

# database for 10 kV Voltage source:
dbLoadRecords("database/${DATABASE}.db", "PREFIX=${PREFIX}, SCAN_RATE=${SCAN_RATE}, SPIxCONV_ADDRESS=${ADDRESS}, VOLTAGE_FACTOR=${VOLTAGE_FACTOR}")

''')

bot =  Template('''
set_pass0_restoreFile("$(TOP)/autosave/save/${PREFIX}.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/${PREFIX}.sav")

# Effectively initializes the IOC
cd iocBoot
iocInit

cd ..
create_monitor_set("$(TOP)/autosave/spixconv.req", 10, "P=${PREFIX}, SAVENAMEPV=${PREFIX}:SaveName")
''')
