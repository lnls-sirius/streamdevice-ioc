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
drvAsynIPPortConfigure("IPPort0","10.128.101.237:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BAK3-SIP20-01,P_CH1=BAK3-SIP20-VPS-INJ01,P_CH2=BAK3-SIP20-VPS-INJ02,P_CH3=BAK3-SIP20-VPS-TR01,P_CH4=BAK3-SIP20-VPS-TR02,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=139,PHAS=1,TIME=4")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-VPS-INJ01,D=BAK3-SIP20-01,CH_NUM=1,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-VPS-INJ02,D=BAK3-SIP20-01,CH_NUM=2,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-VPS-TR01,D=BAK3-SIP20-01,CH_NUM=3,ADDR=139")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-VPS-TR02,D=BAK3-SIP20-01,CH_NUM=4,ADDR=139")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=BAK3-SIP20-02,P_CH1=BAK3-SIP20-VPS-TR03,P_CH2=BAK3-SIP20-VPS-TR04,P_CH3=BAK3-SIP20-C3,P_CH4=BAK3-SIP20-C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=140,PHAS=2,TIME=4")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-VPS-TR03,D=BAK3-SIP20-02,CH_NUM=1,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-VPS-TR04,D=BAK3-SIP20-02,CH_NUM=2,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-C3,D=BAK3-SIP20-02,CH_NUM=3,ADDR=140")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=BAK3-SIP20-C4,D=BAK3-SIP20-02,CH_NUM=4,ADDR=140")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_101_237:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_101_237:5004.sav")

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

create_monitor_set("10_128_101_237:5004.req", 30)
