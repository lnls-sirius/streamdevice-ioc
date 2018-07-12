#!/usr/bin/env python
# -*- coding: utf-8 -*-
from string import Template
from mbtemp_template import mbt_template_cmd as mbt_template_cmd
import sys 

if __name__ == "__main__":
    f_name = "MBTMP.cmd"
    if len(sys.argv) < 2:
        print('[WARNING]: The user should pass as paramater the destination file name.')
    else:
        if sys.argv[1].endswith(".cmd"):
            f_name = sys.argv[1]
        else:
            print('[ERROR]: The file extension must be .cmd.')

    EPICS_BASE = "/opt/epics-R3.15.5/base"
    ASYN = "/opt/epics-R3.15.5/modules/asyn4-33"
    TOP = "/opt/stream-ioc"
    ARCH ="linux-x86_64"
    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    CD = "${TOP}"
     
    # MBTemp specifics
    IP_ASYN_PORT_1 = "IPPort1"
    IP_ADDR_1 = "10.0.6.63:4161"
    MBTEMP_ADDRESS = "8"
    PREFIX_1 = "TEST:MBTemp"
    SCAN_RATE = "2"
    
    # DCM-SE10
    DCM_SE_10 = False #  will be generated or not ....
    IP_ASYN_PORT_2 = "IPPort2"
    IP_ADDR_2 = "10.0.6.63:17001 UDP"
    PREFIX_2 = "TEST:DCM_SE-10"

    if not DCM_SE_10:
        res = mbt_template_cmd.safe_substitute(
            EPICS_BASE=EPICS_BASE,
            ASYN=ASYN,
            TOP=TOP,
            ARCH=ARCH,
            STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
            CD=CD,
            IP_ASYN_PORT_1=IP_PORT,
            IP_ADDR_1=IP_ADDR_1,
            MBTEMP_ADDRESS=MBTEMP_ADDRESS,
            PREFIX_1=PREFIX_1,
            SCAN_RATE = SCAN_RATE)
    else:
        pass
    file = open(f_name, 'w+')
    file.write(res)
    file.close()