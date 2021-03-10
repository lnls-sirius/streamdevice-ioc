#!../../bin/linux-x86_64/procCtrl

< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

cd "$(TOP)"

dbLoadDatabase "dbd/procCtrl.dbd"
procCtrl_registerRecordDeviceDriver pdbbase
asSetFilename("$(TOP)/db/Security.as")

drvAsynIPPortConfigure("P0",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_107_5005.sock")
drvAsynIPPortConfigure("P1",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_108_5005.sock")
drvAsynIPPortConfigure("P2",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_109_5005.sock")
drvAsynIPPortConfigure("P3",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_110_5005.sock")
drvAsynIPPortConfigure("P4",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_111_5005.sock")
drvAsynIPPortConfigure("P5",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_112_5005.sock")
drvAsynIPPortConfigure("P6",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_113_5005.sock")
drvAsynIPPortConfigure("P7",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_180_107_5005.sock")
drvAsynIPPortConfigure("P8",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_180_108_5005.sock")
drvAsynIPPortConfigure("P9",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_180_109_5005.sock")
drvAsynIPPortConfigure("P10",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_180_110_5005.sock")
drvAsynIPPortConfigure("P11",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_114_5005.sock")
drvAsynIPPortConfigure("P12",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_180_111_5005.sock")
drvAsynIPPortConfigure("P13",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_115_5005.sock")
drvAsynIPPortConfigure("P14",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_180_112_5005.sock")
drvAsynIPPortConfigure("P15",  "unix:///opt/streamdevice-ioc/sockets/SPIxCONV-10_128_170_116_5005.sock")

dbLoadRecords("db/procServControl.db","P=ProcCtrl:TB-04:PU-InjSept,PORT=P0,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:TB-04:PU-InjSept")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:BO-01D:PU-InjKckr,PORT=P1,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:BO-01D:PU-InjKckr")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:TS-04:PU-InjSeptG-1,PORT=P2,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:TS-04:PU-InjSeptG-1")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:TS-04:PU-InjSeptG-2,PORT=P3,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:TS-04:PU-InjSeptG-2")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:TS-04:PU-InjSeptF,PORT=P4,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:TS-04:PU-InjSeptF")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SI-01SA:PU-PingH,PORT=P5,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SI-01SA:PU-PingH")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SI-01SA:PU-InjDpKckr,PORT=P6,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SI-01SA:PU-InjDpKckr")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:BO-48D:PU-EjeKckr,PORT=P7,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:BO-48D:PU-EjeKckr")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:TS-01:PU-EjeSeptF,PORT=P8,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:TS-01:PU-EjeSeptF")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:TS-01:PU-EjeSeptG,PORT=P9,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:TS-01:PU-EjeSeptG")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SI-19C4:PU-PingV,PORT=P10,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SI-19C4:PU-PingV")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SpareSeptum1,PORT=P11,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SpareSeptum1")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SpareSeptum2,PORT=P12,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SpareSeptum2")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SpareKicker1,PORT=P13,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SpareKicker1")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SpareKicker2,PORT=P14,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SpareKicker2")
dbLoadRecords("db/procServControl.db","P=ProcCtrl:SI-01SA:PU-InjNLKckr,PORT=P15,SHOWOUT=1,MANUALSTART=,NAME=ProcCtrl:SI-01SA:PU-InjNLKckr")

cd "$(TOP)/iocBoot/iocStreamDeviceIOC"
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

seq(procServControl,"P=ProcCtrl:TB-04:PU-InjSept")
seq(procServControl,"P=ProcCtrl:BO-01D:PU-InjKckr")
seq(procServControl,"P=ProcCtrl:TS-04:PU-InjSeptG-1")
seq(procServControl,"P=ProcCtrl:TS-04:PU-InjSeptG-2")
seq(procServControl,"P=ProcCtrl:TS-04:PU-InjSeptF")
seq(procServControl,"P=ProcCtrl:SI-01SA:PU-PingH")
seq(procServControl,"P=ProcCtrl:SI-01SA:PU-InjDpKckr")
seq(procServControl,"P=ProcCtrl:BO-48D:PU-EjeKckr")
seq(procServControl,"P=ProcCtrl:TS-01:PU-EjeSeptF")
seq(procServControl,"P=ProcCtrl:TS-01:PU-EjeSeptG")
seq(procServControl,"P=ProcCtrl:SI-19C4:PU-PingV")
seq(procServControl,"P=ProcCtrl:SpareSeptum1")
seq(procServControl,"P=ProcCtrl:SpareSeptum2")
seq(procServControl,"P=ProcCtrl:SpareKicker1")
seq(procServControl,"P=ProcCtrl:SpareKicker2")
seq(procServControl,"P=ProcCtrl:SI-01SA:PU-InjNLKckr")
