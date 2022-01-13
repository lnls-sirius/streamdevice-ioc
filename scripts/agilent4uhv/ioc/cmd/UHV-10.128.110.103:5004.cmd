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
drvAsynIPPortConfigure("IPPort0","10.128.110.103:5004", 100, 0, 0)

# Device 1
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA10:VA-SIPC-03,P_CH1=SI-10SB:VA-SIP20-BG,P_CH2=SI-10C1:VA-SIP20-BG,P_CH3=SI-10C2:VA-SIP20-BG,P_CH4=SI-10C3:VA-SIP20-BG,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=141,PHAS=1,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10SB:VA-SIP20-BG,D=SI-RA10:VA-SIPC-03,CH_NUM=1,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10C1:VA-SIP20-BG,D=SI-RA10:VA-SIPC-03,CH_NUM=2,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10C2:VA-SIP20-BG,D=SI-RA10:VA-SIPC-03,CH_NUM=3,ADDR=141")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10C3:VA-SIP20-BG,D=SI-RA10:VA-SIPC-03,CH_NUM=4,ADDR=141")

# Device 2
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA10:VA-SIPC-04,P_CH1=SI-10C4:VA-SIP20-BG,P_CH2=SI-11M1:VA-SIP20-BG,P_CH3=SI-10SBFE:VA-SIP150-MD,P_CH4=SI-10BCFE:VA-SIP150-MD,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=142,PHAS=2,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10C4:VA-SIP20-BG,D=SI-RA10:VA-SIPC-04,CH_NUM=1,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-11M1:VA-SIP20-BG,D=SI-RA10:VA-SIPC-04,CH_NUM=2,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10SBFE:VA-SIP150-MD,D=SI-RA10:VA-SIPC-04,CH_NUM=3,ADDR=142")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10BCFE:VA-SIP150-MD,D=SI-RA10:VA-SIPC-04,CH_NUM=4,ADDR=142")

# Device 3
dbLoadRecords("db/Agilent-4UHV-Device.db", "PORT=IPPort0,P=SI-RA10:VA-SIPC-05,P_CH1=SI-10SB:VA-SIP20-ED,P_CH2=SI-RA10:VA-SIPC-05:C2,P_CH3=SI-RA10:VA-SIPC-05:C3,P_CH4=SI-RA10:VA-SIPC-05:C4,E_CH1=,E_CH2=,E_CH3=,E_CH4=,ADDR=143,PHAS=3,TIME=6")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-10SB:VA-SIP20-ED,D=SI-RA10:VA-SIPC-05,CH_NUM=1,ADDR=143")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-RA10:VA-SIPC-05:C2,D=SI-RA10:VA-SIPC-05,CH_NUM=2,ADDR=143")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-RA10:VA-SIPC-05:C3,D=SI-RA10:VA-SIPC-05,CH_NUM=3,ADDR=143")
dbLoadRecords("db/Agilent-4UHV-Channel.db", "PORT=IPPort0, P=SI-RA10:VA-SIPC-05:C4,D=SI-RA10:VA-SIPC-05,CH_NUM=4,ADDR=143")

set_pass0_restoreFile("$(TOP)/autosave/save/10_128_110_103:5004.sav")
set_pass1_restoreFile("$(TOP)/autosave/save/10_128_110_103:5004.sav")

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

create_monitor_set("10_128_110_103:5004.req", 30)
