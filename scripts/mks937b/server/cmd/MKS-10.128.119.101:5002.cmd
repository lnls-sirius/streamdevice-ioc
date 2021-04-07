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
drvAsynIPPortConfigure("IPPort0","10.128.119.101:5002", 100, 0, 0)

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=BO-RA19:VA-VGC-01, G1=BO-47U:VA-CCG-ED, G2=BO-RA19:VA-VGC-01:A2, G3=BO-48D:VA-CCG-ED, G4=BO-RA19:VA-VGC-01:B2, G5=BO-47U:VA-PIR-ED, G6=BO-49U:VA-PIR-BG, ADDRESS=001, P_PROTO=MKS-10.128.119.101:5002ADDR001, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=BO-RA19:VA-VGC-01, DEVICE=BO-47U:VA-CCG-ED, ADDRESS=001, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=BO-RA19:VA-VGC-01, DEVICE=BO-RA19:VA-VGC-01:A2, ADDRESS=001, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=BO-RA19:VA-VGC-01, DEVICE=BO-48D:VA-CCG-ED, ADDRESS=001, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=BO-RA19:VA-VGC-01, DEVICE=BO-RA19:VA-VGC-01:B2, ADDRESS=001, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=BO-RA19:VA-VGC-01, DEVICE=BO-47U:VA-PIR-ED, ADDRESS=001, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=BO-RA19:VA-VGC-01, DEVICE=BO-49U:VA-PIR-BG, ADDRESS=001, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=BO-47U:VA-CCG-ED, CHANNEL=1, ADDRESS=001")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=BO-48D:VA-CCG-ED, CHANNEL=3, ADDRESS=001")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=BO-RA19:VA-VGC-01, ADDRESS=001")

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=SI-RA19:VA-VGC-01, G1=SI-19SP:VA-CCG-BG, G2=SI-RA19:VA-VGC-01:A2, G3=SI-19C1:VA-CCG-BG, G4=SI-RA19:VA-VGC-01:B2, G5=SI-19SP:VA-PIR-BG, G6=SI-RA19:VA-VGC-01:C2, ADDRESS=002, P_PROTO=MKS-10.128.119.101:5002ADDR002, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-01, DEVICE=SI-19SP:VA-CCG-BG, ADDRESS=002, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-01, DEVICE=SI-RA19:VA-VGC-01:A2, ADDRESS=002, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-01, DEVICE=SI-19C1:VA-CCG-BG, ADDRESS=002, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-01, DEVICE=SI-RA19:VA-VGC-01:B2, ADDRESS=002, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-01, DEVICE=SI-19SP:VA-PIR-BG, ADDRESS=002, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-01, DEVICE=SI-RA19:VA-VGC-01:C2, ADDRESS=002, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=SI-19SP:VA-CCG-BG, CHANNEL=1, ADDRESS=002")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=SI-19C1:VA-CCG-BG, CHANNEL=3, ADDRESS=002")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=SI-RA19:VA-VGC-01, ADDRESS=002")

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=SI-RA19:VA-VGC-02, G1=SI-19C3:VA-CCG-BG, G2=SI-RA19:VA-VGC-02:A2, G3=SI-19SPFE:VA-CCG-MD, G4=SI-RA19:VA-VGC-02:B2, G5=SI-19C3:VA-PIR-BG, G6=SI-19SPFE:VA-PIR-MD, ADDRESS=003, P_PROTO=MKS-10.128.119.101:5002ADDR003, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-02, DEVICE=SI-19C3:VA-CCG-BG, ADDRESS=003, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-02, DEVICE=SI-RA19:VA-VGC-02:A2, ADDRESS=003, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-02, DEVICE=SI-19SPFE:VA-CCG-MD, ADDRESS=003, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-02, DEVICE=SI-RA19:VA-VGC-02:B2, ADDRESS=003, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-02, DEVICE=SI-19C3:VA-PIR-BG, ADDRESS=003, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-02, DEVICE=SI-19SPFE:VA-PIR-MD, ADDRESS=003, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=SI-19C3:VA-CCG-BG, CHANNEL=1, ADDRESS=003")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=SI-19SPFE:VA-CCG-MD, CHANNEL=3, ADDRESS=003")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=SI-RA19:VA-VGC-02, ADDRESS=003")

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=SI-RA19:VA-VGC-03, G1=SI-19C2FE:VA-CCG-MD, G2=SI-RA19:VA-VGC-03:A2, G3=SI-19BCFE:VA-CCG-MD, G4=SI-RA19:VA-VGC-03:B2, G5=SI-19C2FE:VA-PIR-MD, G6=SI-19BCFE:VA-PIR-MD, ADDRESS=004, P_PROTO=MKS-10.128.119.101:5002ADDR004, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-03, DEVICE=SI-19C2FE:VA-CCG-MD, ADDRESS=004, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-03, DEVICE=SI-RA19:VA-VGC-03:A2, ADDRESS=004, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-03, DEVICE=SI-19BCFE:VA-CCG-MD, ADDRESS=004, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-03, DEVICE=SI-RA19:VA-VGC-03:B2, ADDRESS=004, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-03, DEVICE=SI-19C2FE:VA-PIR-MD, ADDRESS=004, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=SI-RA19:VA-VGC-03, DEVICE=SI-19BCFE:VA-PIR-MD, ADDRESS=004, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=SI-19C2FE:VA-CCG-MD, CHANNEL=1, ADDRESS=004")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=SI-19BCFE:VA-CCG-MD, CHANNEL=3, ADDRESS=004")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=SI-RA19:VA-VGC-03, ADDRESS=004")

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=TS-RA19:VA-VGC-04, G1=TS-01:VA-CCG-BG, G2=TS-RA19:VA-VGC-04:A2, G3=TS-01:VA-CCG-ED, G4=TS-RA19:VA-VGC-04:B2, G5=TS-02:VA-PIR-BG, G6=TS-RA19:VA-VGC-04:C2, ADDRESS=005, P_PROTO=MKS-10.128.119.101:5002ADDR005, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-04, DEVICE=TS-01:VA-CCG-BG, ADDRESS=005, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-04, DEVICE=TS-RA19:VA-VGC-04:A2, ADDRESS=005, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-04, DEVICE=TS-01:VA-CCG-ED, ADDRESS=005, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-04, DEVICE=TS-RA19:VA-VGC-04:B2, ADDRESS=005, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-04, DEVICE=TS-02:VA-PIR-BG, ADDRESS=005, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-04, DEVICE=TS-RA19:VA-VGC-04:C2, ADDRESS=005, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=TS-01:VA-CCG-BG, CHANNEL=1, ADDRESS=005")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=TS-01:VA-CCG-ED, CHANNEL=3, ADDRESS=005")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=TS-RA19:VA-VGC-04, ADDRESS=005")

# General mks937b records
dbLoadRecords("db/mks937b.db", "PORT=IPPort0, DEVICE=TS-RA19:VA-VGC-05, G1=TS-04:VA-CCG-BG, G2=TS-RA19:VA-VGC-05:A2, G3=TS-04:VA-CCG-MD, G4=TS-RA19:VA-VGC-05:B2, G5=TS-04:VA-PIR-BG, G6=TS-RA19:VA-VGC-05:C2, ADDRESS=006, P_PROTO=MKS-10.128.119.101:5002ADDR006, SCAN_RATE=.1 second")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-05, DEVICE=TS-04:VA-CCG-BG, ADDRESS=006, CHANNEL=1, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-05, DEVICE=TS-RA19:VA-VGC-05:A2, ADDRESS=006, CHANNEL=2, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-05, DEVICE=TS-04:VA-CCG-MD, ADDRESS=006, CHANNEL=3, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-05, DEVICE=TS-RA19:VA-VGC-05:B2, ADDRESS=006, CHANNEL=4, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-05, DEVICE=TS-04:VA-PIR-BG, ADDRESS=006, CHANNEL=5, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_pressure.db", "PORT=IPPort0, D=TS-RA19:VA-VGC-05, DEVICE=TS-RA19:VA-VGC-05:C2, ADDRESS=006, CHANNEL=6, P_HI=1e-7, P_HIHI=1e-5")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=TS-04:VA-CCG-BG, CHANNEL=1, ADDRESS=006")
dbLoadRecords("db/mks937b_cc.db", "PORT=IPPort0, DEVICE=TS-04:VA-CCG-MD, CHANNEL=3, ADDRESS=006")
dbLoadRecords("db/mks937b_relay.db", "PORT=IPPort0, DEVICE=TS-RA19:VA-VGC-05, ADDRESS=006")


set_requestfile_path("$(TOP)", "autosave")
set_savefile_path("$(TOP)/autosave/save")

# Offsets
set_pass0_restoreFile("$(TOP)/autosave/MKS-10.128.119.101:5002.sav")
set_pass1_restoreFile("$(TOP)/autosave/MKS-10.128.119.101:5002.sav")

save_restoreSet_DatedBackupFiles(1)
save_restoreSet_NumSeqFiles(2)
save_restoreSet_SeqPeriodInSeconds(600)

# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

create_monitor_set("MKS-10.128.119.101:5002.req", 30)
