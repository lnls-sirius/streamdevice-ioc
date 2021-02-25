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
drvAsynIPPortConfigure("IPPort0","10.128.111.103:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SR-RA11:VA-SIPC-03,P_CH1=SI-11SP:VA-SIP20-BG,P_CH2=SI-11C1:VA-SIP20-BG,P_CH3=SI-11C2:VA-SIP20-BG,P_CH4=SI-11C3:VA-SIP20-BG,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=141,PHAS=1,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11SP:VA-SIP20-BG,D=SR-RA11:VA-SIPC-03,CH_NUM=1,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11C1:VA-SIP20-BG,D=SR-RA11:VA-SIPC-03,CH_NUM=2,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11C2:VA-SIP20-BG,D=SR-RA11:VA-SIPC-03,CH_NUM=3,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11C3:VA-SIP20-BG,D=SR-RA11:VA-SIPC-03,CH_NUM=4,ADDR=141")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SR-RA11:VA-SIPC-04,P_CH1=SI-11C4:VA-SIP20-BG,P_CH2=SI-12M1:VA-SIP20-BG,P_CH3=SR-RA11:VA-SIPC-04:C3,P_CH4=SR-RA11:VA-SIPC-04:C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=142,PHAS=2,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11C4:VA-SIP20-BG,D=SR-RA11:VA-SIPC-04,CH_NUM=1,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-12M1:VA-SIP20-BG,D=SR-RA11:VA-SIPC-04,CH_NUM=2,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SR-RA11:VA-SIPC-04:C3,D=SR-RA11:VA-SIPC-04,CH_NUM=3,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SR-RA11:VA-SIPC-04:C4,D=SR-RA11:VA-SIPC-04,CH_NUM=4,ADDR=142")

# Device 3
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SR-RA11:VA-SIPC-05,P_CH1=SI-11SPFE:VA-SIP150-MD,P_CH2=SI-11C2FE:VA-SIP150-MD,P_CH3=SI-11BCFE:VA-SIP150-MD,P_CH4=SR-RA11:VA-SIPC-05:C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=143,PHAS=3,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11SPFE:VA-SIP150-MD,D=SR-RA11:VA-SIPC-05,CH_NUM=1,ADDR=143")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11C2FE:VA-SIP150-MD,D=SR-RA11:VA-SIPC-05,CH_NUM=2,ADDR=143")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11BCFE:VA-SIP150-MD,D=SR-RA11:VA-SIPC-05,CH_NUM=3,ADDR=143")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SR-RA11:VA-SIPC-05:C4,D=SR-RA11:VA-SIPC-05,CH_NUM=4,ADDR=143")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_111_103:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_111_103:5004.sav")

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

create_monitor_set("10_128_111_103:5004.req", 30)
