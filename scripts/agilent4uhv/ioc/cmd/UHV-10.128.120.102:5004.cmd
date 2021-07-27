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
drvAsynIPPortConfigure("IPPort0","10.128.120.102:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=TB-RA20:VA-SIPC-01,P_CH1=TB-01:VA-SIP20-BG,P_CH2=TB-01:VA-SIP20-ED,P_CH3=TB-02:VA-SIP20-BG,P_CH4=TB-02:VA-SIP20-MD,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=139,PHAS=1,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-01:VA-SIP20-BG,D=TB-RA20:VA-SIPC-01,CH_NUM=1,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-01:VA-SIP20-ED,D=TB-RA20:VA-SIPC-01,CH_NUM=2,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-02:VA-SIP20-BG,D=TB-RA20:VA-SIPC-01,CH_NUM=3,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-02:VA-SIP20-MD,D=TB-RA20:VA-SIPC-01,CH_NUM=4,ADDR=139")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=TB-RA20:VA-SIPC-02,P_CH1=TB-02:VA-SIP20-ED,P_CH2=TB-03:VA-SIP20-ED,P_CH3=TB-04:VA-SIP20-ED,P_CH4=TB-RA20:VA-SIPC-02:C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=140,PHAS=2,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-02:VA-SIP20-ED,D=TB-RA20:VA-SIPC-02,CH_NUM=1,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-03:VA-SIP20-ED,D=TB-RA20:VA-SIPC-02,CH_NUM=2,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-04:VA-SIP20-ED,D=TB-RA20:VA-SIPC-02,CH_NUM=3,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TB-RA20:VA-SIPC-02:C4,D=TB-RA20:VA-SIPC-02,CH_NUM=4,ADDR=140")

# Device 3
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BO-RA20:VA-SIPC-03,P_CH1=BO-48U:VA-SIP20-ED,P_CH2=BO-48D:VA-SIP20-ED,P_CH3=BO-49U:VA-SIP20-BG,P_CH4=BO-49U:VA-SIP20-ED,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=141,PHAS=3,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-48U:VA-SIP20-ED,D=BO-RA20:VA-SIPC-03,CH_NUM=1,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-48D:VA-SIP20-ED,D=BO-RA20:VA-SIPC-03,CH_NUM=2,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-49U:VA-SIP20-BG,D=BO-RA20:VA-SIPC-03,CH_NUM=3,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BO-49U:VA-SIP20-ED,D=BO-RA20:VA-SIPC-03,CH_NUM=4,ADDR=141")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_120_102:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_120_102:5004.sav")

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

create_monitor_set("10_128_120_102:5004.req", 30)
