#!../../bin/linux-x86_64/streamDeviceIOC
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
drvAsynIPPortConfigure("IPPort0","10.128.112.102:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BO-RA12:VA-SIPC-01,P_CH1=BO-28U:VA-SIP20-ED,P_CH2=BO-28D:VA-SIP20-ED,P_CH3=BO-29U:VA-SIP20-BG,P_CH4=BO-29U:VA-SIP20-ED,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=139,PHAS=1,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-28U:VA-SIP20-ED,D=BO-RA12:VA-SIPC-01,CH_NUM=1,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-28D:VA-SIP20-ED,D=BO-RA12:VA-SIPC-01,CH_NUM=2,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-29U:VA-SIP20-BG,D=BO-RA12:VA-SIPC-01,CH_NUM=3,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-29U:VA-SIP20-ED,D=BO-RA12:VA-SIPC-01,CH_NUM=4,ADDR=139")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BO-RA12:VA-SIPC-02,P_CH1=BO-29D:VA-SIP20-ED,P_CH2=BO-30U:VA-SIP20-BG,P_CH3=BO-30U:VA-SIP20-ED,P_CH4=BO-30D:VA-SIP20-ED,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=140,PHAS=2,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-29D:VA-SIP20-ED,D=BO-RA12:VA-SIPC-02,CH_NUM=1,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-30U:VA-SIP20-BG,D=BO-RA12:VA-SIPC-02,CH_NUM=2,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-30U:VA-SIP20-ED,D=BO-RA12:VA-SIPC-02,CH_NUM=3,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-30D:VA-SIP20-ED,D=BO-RA12:VA-SIPC-02,CH_NUM=4,ADDR=140")

# Device 3
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA12:VA-SIPC-03,P_CH1=SI-12SB:VA-SIP20-BG,P_CH2=SI-12C1:VA-SIP20-BG,P_CH3=SI-12C2:VA-SIP20-BG,P_CH4=SI-12C3:VA-SIP20-BG,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=141,PHAS=3,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12SB:VA-SIP20-BG,D=SI-RA12:VA-SIPC-03,CH_NUM=1,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12C1:VA-SIP20-BG,D=SI-RA12:VA-SIPC-03,CH_NUM=2,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12C2:VA-SIP20-BG,D=SI-RA12:VA-SIPC-03,CH_NUM=3,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12C3:VA-SIP20-BG,D=SI-RA12:VA-SIPC-03,CH_NUM=4,ADDR=141")

# Device 4
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA12:VA-SIPC-04,P_CH1=SI-12C4:VA-SIP20-BG,P_CH2=SI-13M1:VA-SIP20-BG,P_CH3=SI-12SBFE:VA-SIP150-MD,P_CH4=SI-12BCFE:VA-SIP150-MD,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=142,PHAS=4,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12C4:VA-SIP20-BG,D=SI-RA12:VA-SIPC-04,CH_NUM=1,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-13M1:VA-SIP20-BG,D=SI-RA12:VA-SIPC-04,CH_NUM=2,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12SBFE:VA-SIP150-MD,D=SI-RA12:VA-SIPC-04,CH_NUM=3,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12BCFE:VA-SIP150-MD,D=SI-RA12:VA-SIPC-04,CH_NUM=4,ADDR=142")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_112_102:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_112_102:5004.sav")

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

create_monitor_set("10_128_112_102:5004.req", 30)
