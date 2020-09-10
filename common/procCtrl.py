#!/usr/bin/python
import os
import json

header = """#!../../bin/linux-x86_64/procCtrl

< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

cd "${TOP}"

dbLoadDatabase "dbd/procCtrl.dbd"
procCtrl_registerRecordDeviceDriver pdbbase
asSetFilename("${TOP}/db/Security.as")

"""
init = """
cd "${TOP}/iocBoot/${IOC}"
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

"""


def generate_st_cmd(iocs):
    data = header
    port = 0
    asynIP = ""
    seq = ""
    db = ""
    for ioc in iocs:
        asynIP += 'drvAsynIPPortConfigure("P{0}",  "unix://{1}")\n'.format(
            port, ioc["ip"]
        )
        seq += 'seq(procServControl,"P={0}")\n'.format(ioc["pv"])
        db += 'dbLoadRecords("db/procServControl.db","P={1},PORT=P{0},SHOWOUT=1,MANUALSTART=,NAME={1}")\n'.format(
            port, ioc["pv"]
        )
        port += 1
    data += asynIP
    data += "\n"
    data += db
    data += init
    data += seq
    with open("/opt/procCtrl/iocBoot/iocprocCtrl/st.cmd", "w+") as f:
        f.write(data)

    os.chmod("/opt/procCtrl/iocBoot/iocprocCtrl/st.cmd", 0o754)
