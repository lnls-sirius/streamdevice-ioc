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
drvAsynIPPortConfigure("IPPort0","10.128.118.102:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BO-RA18:VA-SIPC-01,P_CH1=BO-43D:VA-SIP20-ED,P_CH2=BO-44U:VA-SIP20-BG,P_CH3=BO-44U:VA-SIP20-ED,P_CH4=BO-44D:VA-SIP20-ED,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=139,PHAS=1,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-43D:VA-SIP20-ED,D=BO-RA18:VA-SIPC-01,CH_NUM=1,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-44U:VA-SIP20-BG,D=BO-RA18:VA-SIPC-01,CH_NUM=2,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-44U:VA-SIP20-ED,D=BO-RA18:VA-SIPC-01,CH_NUM=3,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-44D:VA-SIP20-ED,D=BO-RA18:VA-SIPC-01,CH_NUM=4,ADDR=139")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BO-RA18:VA-SIPC-02,P_CH1=BO-45U:VA-SIP20-BG,P_CH2=BO-45U:VA-SIP20-ED,P_CH3=BO-45D:VA-SIP20-ED,P_CH4=BO-RA18:VA-SIPC-02:C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=140,PHAS=2,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-45U:VA-SIP20-BG,D=BO-RA18:VA-SIPC-02,CH_NUM=1,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-45U:VA-SIP20-ED,D=BO-RA18:VA-SIPC-02,CH_NUM=2,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-45D:VA-SIP20-ED,D=BO-RA18:VA-SIPC-02,CH_NUM=3,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-RA18:VA-SIPC-02:C4,D=BO-RA18:VA-SIPC-02,CH_NUM=4,ADDR=140")

# Device 3
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA18:VA-SIPC-03,P_CH1=SI-18SB:VA-SIP20-BG,P_CH2=SI-18C1:VA-SIP20-BG,P_CH3=SI-18C2:VA-SIP20-BG,P_CH4=SI-18C3:VA-SIP20-BG,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=141,PHAS=3,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18SB:VA-SIP20-BG,D=SI-RA18:VA-SIPC-03,CH_NUM=1,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18C1:VA-SIP20-BG,D=SI-RA18:VA-SIPC-03,CH_NUM=2,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18C2:VA-SIP20-BG,D=SI-RA18:VA-SIPC-03,CH_NUM=3,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18C3:VA-SIP20-BG,D=SI-RA18:VA-SIPC-03,CH_NUM=4,ADDR=141")

# Device 4
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA18:VA-SIPC-04,P_CH1=SI-18C4:VA-SIP20-BG,P_CH2=SI-19M1:VA-SIP20-BG,P_CH3=SI-18SBFE:VA-SIP150-MD,P_CH4=SI-18BCFE:VA-SIP150-MD,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=142,PHAS=4,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18C4:VA-SIP20-BG,D=SI-RA18:VA-SIPC-04,CH_NUM=1,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-19M1:VA-SIP20-BG,D=SI-RA18:VA-SIPC-04,CH_NUM=2,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18SBFE:VA-SIP150-MD,D=SI-RA18:VA-SIPC-04,CH_NUM=3,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-18BCFE:VA-SIP150-MD,D=SI-RA18:VA-SIPC-04,CH_NUM=4,ADDR=142")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_118_102:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_118_102:5004.sav")

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

create_monitor_set("10_128_118_102:5004.req", 30)
