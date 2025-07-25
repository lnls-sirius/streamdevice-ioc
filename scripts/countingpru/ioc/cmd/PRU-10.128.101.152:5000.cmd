#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file

cd $(TOP)
dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

# Port for the device
drvAsynIPPortConfigure("IPPort0", "10.128.101.152:5000", 100, 0, 0)


# Record for configuration of TimeBase
dbLoadRecords("db/CountingPRU-Device.db", "PORT=IPPort0,PREFIX=SI-01C2:CO-Counter,CH1=SI-01C1:CO-GammaDetector,CH2=nan,CH3=nan,CH4=SI-01C2:CO-GammaDetector,CH5=nan,CH6=nan,CH7=nan,CH8=nan")

# Records corresponding to the eight countings
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=1,SN_ID=11,DESCRIPTION=LNLS 1 - Ch1,PORT=IPPort0,RECORD_NAME=SI-01M2:CO-Gamma,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=SI-01C1:CO-GammaDetector")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=2,SN_ID=12,DESCRIPTION=LNLS 1 - Ch2,PORT=IPPort0,RECORD_NAME=SI-01C2:CO-Counter-Ch2,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=nan")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=3,SN_ID=13,DESCRIPTION=LNLS 1 - Ch3,PORT=IPPort0,RECORD_NAME=SI-01C2:CO-Counter-Ch3,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=nan")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=4,SN_ID=14,DESCRIPTION=LNLS 2 - Ch1,PORT=IPPort0,RECORD_NAME=SI-01C1:CO-Gamma,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=SI-01C2:CO-GammaDetector")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=5,SN_ID=15,DESCRIPTION=LNLS 2 - Ch2,PORT=IPPort0,RECORD_NAME=SI-01C2:CO-Counter-Ch5,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=nan")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=6,SN_ID=16,DESCRIPTION=LNLS 2 - Ch3,PORT=IPPort0,RECORD_NAME=SI-01C2:CO-Counter-Ch6,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=nan")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=7,SN_ID=17,DESCRIPTION=BLM Bergoz Diff 1,PORT=IPPort0,RECORD_NAME=SI-01C2:CO-Counter-Ch7,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=nan")
dbLoadRecords("db/CountingPRU-Channel.db", "CHANNEL=8,SN_ID=18,DESCRIPTION=BLM Bergoz Diff 2,PORT=IPPort0,RECORD_NAME=SI-01C2:CO-Counter-Ch8,SCAN_RATE=2 second,BOARD_NAME=SI-01C2:CO-Counter,DETECTOR_NAME=nan")


# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

