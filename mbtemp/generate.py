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

from os import environ, path, makedirs

from string import Template
sys.path.append(path.join(path.dirname(path.abspath(__file__)),'../'))

from mbtemp.template import mbt_template, mbt_template_bot, mbt_template_top
from mbtemp.devices import boards

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
    for board in boards:
        res = ''
        count = 0

        res += mbt_template_top.safe_substitute(
                CD=CD,
                EPICS_BASE=EPICS_BASE,
                ASYN=ASYN,
                TOP=TOP,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
                IP_ADDR=board.ip,
                EPICS_CA_SERVER_PORT=EPICS_CA_SERVER_PORT,
                IP_ASYN_PORT=board.ip_asyn_port
        )

        for device in board.devices:

            res += mbt_template.safe_substitute(
                IP_ASYN_PORT=board.ip_asyn_port,
                MBTEMP_ADDRESS=device.address,
                PREFIX=device.prefix,
                SCAN_RATE =board.scan_rate,
                CH1=device.channels[0],
                CH2=device.channels[1],
                CH3=device.channels[2],
                CH4=device.channels[3],
                CH5=device.channels[4],
                CH6=device.channels[5],
                CH7=device.channels[6],
                CH8=device.channels[7])

            count += 1

        if EPICS_CA_PORT_INCRESE:
            EPICS_CA_SERVER_PORT += 2
        res += mbt_template_bot

        if not path.exists('server/cmd/'):
            makedirs('server/cmd/')

        with open('server/cmd/' + CMD_KEY + board.file_name, 'w+') as file:
            file.write(res)
