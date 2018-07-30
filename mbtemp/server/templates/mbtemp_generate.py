#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""

from string import Template
from mbtemp_template import mbt_template as mbt_template_cmd
from mbtemp_devices import devices  as devices

import sys 

if __name__ == "__main__":


    EPICS_BASE = "/opt/epics-R3.15.5/base"
    ASYN = "/opt/epics-R3.15.5/modules/asyn4-33"
    TOP = "/opt/stream-ioc"
    ARCH ="linux-x86_64"
    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    CD = "${TOP}"
     
    # MBTemp specifics
 
    for device in devices:

        f_name = device['f_name']
        IP_ASYN_PORT_1 = device['IP_ASYN_PORT_1']
        IP_ADDR_1 = device['IP_ADDR_1']
        MBTEMP_ADDRESS = device['MBTEMP_ADDRESS']
        PREFIX_1 = device['PREFIX_1']
        SCAN_RATE = device['SCAN_RATE']
 
        res = mbt_template_cmd.safe_substitute(
            EPICS_BASE=EPICS_BASE,
            ASYN=ASYN,
            TOP=TOP,
            ARCH=ARCH,
            STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
            CD=CD,
            IP_ASYN_PORT_1=IP_ASYN_PORT_1,
            IP_ADDR_1=IP_ADDR_1,
            MBTEMP_ADDRESS=MBTEMP_ADDRESS,
            PREFIX_1=PREFIX_1,
            SCAN_RATE = SCAN_RATE)
        
        file = open(f_name, 'w+')
        file.write(res)
        file.close()