#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""

from string import Template
from mks937b_template import template_device, template_bot,\
                        template_top, template_pressure, template_cc,\
                        template_relay
from mks937b_devices import sectors  as sectors

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
        IP_ADDR   = sector['IP_ADDR']

        res += template_top.safe_substitute(
                CD=CD,
                EPICS_BASE=EPICS_BASE,
                ASYN=ASYN,
                TOP=TOP,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
                IP_ADDR=IP_ADDR,
                IP_ASYN_PORT=(IP_ASYN_PORT + str(count))
        )
        

        for device in devices:

            PREFIX = device['PREFIX']
            ADDRESS= device['ADDRESS']
            pressures = device['pressures']
    
            res += template_device.safe_substitute( 
                IP_ASYN_PORT=(IP_ASYN_PORT + str(count)), 
                PREFIX=PREFIX,
                SCAN_RATE = SCAN_RATE,
                ADDRESS=ADDRESS
            )
            
            for channel in range(0, 6):
                res += template_pressure.safe_substitute(
                    IP_ASYN_PORT=(IP_ASYN_PORT + str(count)),
                    PREFIX=PREFIX,
                    ADDRESS=ADDRESS,
                    SCAN_RATE = SCAN_RATE,
                    P_HI   = pressures[channel].get('HI'),
                    P_HIHI = pressures[channel].get('HIHI'),
                    CHANNEL = channel + 1 
                )
                 
            for channel in [1,3,5]:
                res += template_cc.safe_substitute(
                    IP_ASYN_PORT=(IP_ASYN_PORT + str(count)),
                    PREFIX=PREFIX,
                    ADDRESS=ADDRESS,
                    SCAN_RATE = SCAN_RATE,
                    CHANNEL = channel
                )

            for relay in range(1, 13):
                res += template_relay.safe_substitute(
                    IP_ASYN_PORT=(IP_ASYN_PORT + str(count)),
                    PREFIX=PREFIX,
                    ADDRESS=ADDRESS,
                    SCAN_RATE = SCAN_RATE,
                    RELAY = relay
                )

            count += 1

        res += template_bot

        file = open(f_name, 'w+')
        file.write(res)
        file.close()