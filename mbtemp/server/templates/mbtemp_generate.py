#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""

from string import Template
from mbtemp_template import mbt_template, mbt_template_bot, mbt_template_top
from mbtemp_devices import sectors  as sectors

import sys 

if __name__ == "__main__":


    EPICS_BASE = "/opt/epics-R3.15.5/base"
    ASYN = "/opt/epics-R3.15.5/modules/asyn4-33"
    TOP = "/opt/stream-ioc"
    ARCH ="linux-x86_64"
    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    CD = "${TOP}"
     
    # MBTemp specifics
    for sector in sectors:
        res = ''
        count = 0

        f_name = '../cmd/' + sector['f_name']
        devices = sector['devices']
        IP_ASYN_PORT = sector['IP_ASYN_PORT']
        SCAN_RATE = sector['SCAN_RATE']

        res += mbt_template_top.safe_substitute(
                EPICS_BASE=EPICS_BASE,
                ASYN=ASYN,
                TOP=TOP,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
        )
        

        for device in devices:
            
            IP_ADDR= device['IP_ADDR']
            MBTEMP_ADDRESS = device['MBTEMP_ADDRESS']
            PREFIX = device['PREFIX']
    
            res += mbt_template.safe_substitute(
                CD=CD,
                IP_ASYN_PORT=(IP_ASYN_PORT + str(count)),
                IP_ADDR=IP_ADDR,
                MBTEMP_ADDRESS=MBTEMP_ADDRESS,
                PREFIX=PREFIX,
                SCAN_RATE = SCAN_RATE)
            
            count += 1

        res += mbt_template_bot

        file = open(f_name, 'w+')
        file.write(res)
        file.close()