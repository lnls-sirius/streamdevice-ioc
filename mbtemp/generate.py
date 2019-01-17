#!/usr/bin/python3
# # -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""
import sys
import time
import argparse
import logging

from os import environ, path

from string import Template
sys.path.append(path.join(path.dirname(path.abspath(__file__)),'../'))

from mbtemp.template import mbt_template, mbt_template_bot, mbt_template_top
from mbtemp.devices import sectors  as sectors

logger = logging.getLogger()
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate MBTemp IOC files.')
    parser.add_argument('--epics-ca-port-increase', help='Increase EPICS_CA_SERVER_PORT by 2 for each deployed IOC.', action='store_true')
    parser.add_argument('--base-epics-ca-port', help='Initial EPICS CA server port. It will increase by 2 for every ioc.', type=int, default=5064)
    parser.add_argument('--cmd-prefix', default='MBT', help='Prefix for the .cmd files.')
    parser.add_argument('--epics-base', default='/opt/epics-R3.15.5/base', help='Epics base path.')
    parser.add_argument('--asyn', default='/opt/epics-R3.15.5/modules/asyn4-33', help='Asyn driver path.')
    parser.add_argument('--top', default='/opt/stream-ioc', help='Stream-ioc path.')
    parser.add_argument('--arch', help='System architecture.', choices=['linux-x86_64', 'linux-arm'], default='linux-x86_64')
    args = parser.parse_args()

    EPICS_BASE = args.epics_base
    ASYN = args.asyn
    TOP =  args.top
    ARCH = args.arch
    EPICS_CA_PORT_INCRESE = args.epics_ca_port_increase
    EPICS_CA_SERVER_PORT = args.base_epics_ca_port
    CMD_KEY = args.cmd_prefix

    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    CD = "${TOP}"

    # MBTemp specifics
    for sector in sectors:
        res = ''
        count = 0

        devices = sector['devices']
        IP_ASYN_PORT = 'IPPort0'
        SCAN_RATE = sector['SCAN_RATE']
        IP_ADDR = sector['IP_ADDR']

        res += mbt_template_top.safe_substitute(
                CD=CD,
                EPICS_BASE=EPICS_BASE,
                ASYN=ASYN,
                TOP=TOP,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
                IP_ADDR=IP_ADDR,
                EPICS_CA_SERVER_PORT=EPICS_CA_SERVER_PORT,
                IP_ASYN_PORT=IP_ASYN_PORT
        )

        for device in devices:
            MBTEMP_ADDRESS = device['MBTEMP_ADDRESS']
            PREFIX = device['PREFIX']
            CH = device['channels']

            res += mbt_template.safe_substitute(
                IP_ASYN_PORT=(IP_ASYN_PORT),
                MBTEMP_ADDRESS=MBTEMP_ADDRESS,
                PREFIX=PREFIX,
                SCAN_RATE = SCAN_RATE,
                CH1=CH[0],
                CH2=CH[1],
                CH3=CH[2],
                CH4=CH[3],
                CH5=CH[4],
                CH6=CH[5],
                CH7=CH[6],
                CH8=CH[7])

            count += 1
        
        if EPICS_CA_PORT_INCRESE:
            EPICS_CA_SERVER_PORT += 2
        res += mbt_template_bot

        with open('server/cmd/' + CMD_KEY + sector['f_name'], 'w+') as file:
            file.write(res)
