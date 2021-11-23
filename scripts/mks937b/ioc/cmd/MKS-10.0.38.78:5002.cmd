#!../../bin/linux-x86_64/streamDeviceIOC
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
drvAsynIPPortConfigure("IPPort0","10.0.38.78:5002", 100, 0, 0)

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=IT-Ra:VA-VGC-01, G1=IT-EGH:VA-CCG, G2=IT-Ra:VA-VGC-01:A2, G3=IT-Ra:VA-VGC-01:B1, G4=IT-Ra:VA-VGC-01:B2, G5=IT-Ra:VA-VGC-01:C1, G6=IT-Ra:VA-VGC-01:C2, ADDRESS=253, P_PROTO=MKS-10.0.38.78:5002ADDR253, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=IT-Ra:VA-VGC-01, DEVICE=IT-EGH:VA-CCG, ADDRESS=253, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=IT-Ra:VA-VGC-01, DEVICE=IT-Ra:VA-VGC-01:A2, ADDRESS=253, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=IT-Ra:VA-VGC-01, DEVICE=IT-Ra:VA-VGC-01:B1, ADDRESS=253, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=IT-Ra:VA-VGC-01, DEVICE=IT-Ra:VA-VGC-01:B2, ADDRESS=253, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=IT-Ra:VA-VGC-01, DEVICE=IT-Ra:VA-VGC-01:C1, ADDRESS=253, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=IT-Ra:VA-VGC-01, DEVICE=IT-Ra:VA-VGC-01:C2, ADDRESS=253, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=IT-EGH:VA-CCG, CHANNEL=1, ADDRESS=253")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=IT-Ra:VA-VGC-01:B1, CHANNEL=3, ADDRESS=253")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=IT-Ra:VA-VGC-01, ADDRESS=253")


set_requestfile_path("$(TOP)", "autosave")
set_savefile_path("$(TOP)/autosave/save")

# Offsets
set_pass0_restoreFile("$(TOP)/autosave/MKS-10.0.38.78:5002.sav")
set_pass1_restoreFile("$(TOP)/autosave/MKS-10.0.38.78:5002.sav")

save_restoreSet_DatedBackupFiles(1)
save_restoreSet_NumSeqFiles(2)
save_restoreSet_SeqPeriodInSeconds(600)

# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

create_monitor_set("MKS-10.0.38.78:5002.req", 30)
