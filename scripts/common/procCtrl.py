#!/usr/bin/env python3
import os

header = """#!../../bin/linux-x86_64/procCtrl

< envPaths

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

cd "$(TOP)"

dbLoadDatabase "dbd/procCtrl.dbd"
procCtrl_registerRecordDeviceDriver pdbbase
asSetFilename("$(TOP)/db/Security.as")

"""
init = """
cd "$(TOP)/iocBoot/iocStreamDeviceIOC"
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

"""


def generate_st_cmd(iocs, dir_name):
    data = header
    port = 0
    asynIP = ""
    seq = ""
    db = ""
    for ioc in iocs:
        asynIP += f'drvAsynIPPortConfigure("P{port}",  "unix://{ioc["ip"]}")\n'
        seq += f'seq(procServControl,"P={ioc["pv"]}")\n'
        db += f'dbLoadRecords("db/procServControl.db","P={ioc["pv"]},PORT=P{port},SHOWOUT=1,MANUALSTART=,NAME={ioc["pv"]}")\n'
        port += 1
    data += asynIP
    data += "\n"
    data += db
    data += init
    data += seq
    p_dir_name = os.path.join(dir_name, "ioc/procCtrl/")
    file_name = os.path.join(p_dir_name, "st.cmd")

    if not os.path.exists(p_dir_name):
        os.makedirs(p_dir_name)
    with open(file_name, "w+") as f:
        f.write(data)

    os.chmod(file_name, 0o774)
