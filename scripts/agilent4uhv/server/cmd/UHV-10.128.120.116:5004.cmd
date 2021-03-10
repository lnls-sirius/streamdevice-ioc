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
drvAsynIPPortConfigure("IPPort0","10.128.120.116:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=TS-RA19:VA-SIPC-06,P_CH1=TS-01:VA-SIP20-BG,P_CH2=TS-01:VA-SIP20-MD1,P_CH3=TS-01:VA-SIP20-MD2,P_CH4=TS-01:VA-SIP20-ED,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=144,PHAS=1,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-01:VA-SIP20-BG,D=TS-RA19:VA-SIPC-06,CH_NUM=1,ADDR=144")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-01:VA-SIP20-MD1,D=TS-RA19:VA-SIPC-06,CH_NUM=2,ADDR=144")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-01:VA-SIP20-MD2,D=TS-RA19:VA-SIPC-06,CH_NUM=3,ADDR=144")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-01:VA-SIP20-ED,D=TS-RA19:VA-SIPC-06,CH_NUM=4,ADDR=144")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=TS-RA19:VA-SIPC-07,P_CH1=TS-02:VA-SIP20-BG,P_CH2=TS-02:VA-SIP20-ED,P_CH3=TS-03:VA-SIP20-BG,P_CH4=TS-03:VA-SIP20-ED,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=145,PHAS=2,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-02:VA-SIP20-BG,D=TS-RA19:VA-SIPC-07,CH_NUM=1,ADDR=145")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-02:VA-SIP20-ED,D=TS-RA19:VA-SIPC-07,CH_NUM=2,ADDR=145")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-03:VA-SIP20-BG,D=TS-RA19:VA-SIPC-07,CH_NUM=3,ADDR=145")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-03:VA-SIP20-ED,D=TS-RA19:VA-SIPC-07,CH_NUM=4,ADDR=145")

# Device 3
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=TS-RA19:VA-SIPC-08,P_CH1=TS-04:VA-SIP20-BG,P_CH2=TS-04:VA-SIP20-MD1,P_CH3=TS-04:VA-SIP20-MD2,P_CH4=TS-04:VA-SIP20-MD3,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=146,PHAS=3,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-04:VA-SIP20-BG,D=TS-RA19:VA-SIPC-08,CH_NUM=1,ADDR=146")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-04:VA-SIP20-MD1,D=TS-RA19:VA-SIPC-08,CH_NUM=2,ADDR=146")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-04:VA-SIP20-MD2,D=TS-RA19:VA-SIPC-08,CH_NUM=3,ADDR=146")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-04:VA-SIP20-MD3,D=TS-RA19:VA-SIPC-08,CH_NUM=4,ADDR=146")

# Device 4
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=TS-RA19:VA-SIPC-09,P_CH1=TS-04:VA-SIP20-ED,P_CH2=TS-RA19:VA-SIPC-09:C2,P_CH3=TS-RA19:VA-SIPC-09:C3,P_CH4=TS-RA19:VA-SIPC-09:C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=147,PHAS=4,TIME=8")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-04:VA-SIP20-ED,D=TS-RA19:VA-SIPC-09,CH_NUM=1,ADDR=147")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-RA19:VA-SIPC-09:C2,D=TS-RA19:VA-SIPC-09,CH_NUM=2,ADDR=147")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-RA19:VA-SIPC-09:C3,D=TS-RA19:VA-SIPC-09,CH_NUM=3,ADDR=147")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=TS-RA19:VA-SIPC-09:C4,D=TS-RA19:VA-SIPC-09,CH_NUM=4,ADDR=147")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_120_116:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_120_116:5004.sav")

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

create_monitor_set("10_128_120_116:5004.req", 30)
