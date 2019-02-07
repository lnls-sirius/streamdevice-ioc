#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""
import argparse
import logging
import sys
import time
from os import environ, path, makedirs
from string import Template

sys.path.append(path.join(path.dirname(path.abspath(__file__)),'../'))
from spixconv.cmd_template import top as template_top, bot as template_bot
from spixconv.devices import boards

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Generate SPIxCONV IOC files.')
    parser.add_argument('--epics-ca-port-increase', help='Increase EPICS_CA_SERVER_PORT by 2 for each deployed IOC.', action='store_true')
    parser.add_argument('--base-epics-ca-port', help='Initial EPICS CA server port. It will increase by 2 for every ioc.', type=int, default=5064)
    parser.add_argument('--cmd-prefix', default='SPIxCONV', help='Prefix for the .cmd files.')
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

    CD = "${TOP}"
    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"

    for board in boards:
        res = ''
        count = 0
        devices_num = 0

        res += template_top.safe_substitute(
                CD=CD,
                EPICS_BASE=EPICS_BASE,
                TOP=TOP,
                ASYN=ASYN,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
                EPICS_CA_SERVER_PORT=EPICS_CA_SERVER_PORT,

                IP_ADDR=board.ip,
                DATABASE=board.database,
                SCAN_RATE=board.scan_rate,
                PREFIX=board.device,
                VOLTAGE_FACTOR=board.voltage_factor,
                DESCRIPTION=board.description,
                ADDRESS=board.address
        )
        res += template_bot

        if EPICS_CA_PORT_INCRESE:
            EPICS_CA_SERVER_PORT += 2
        res += template_bot

        if not path.exists('server/cmd/'):
            makedirs('server/cmd/')

        with open('server/cmd/' + CMD_KEY + board.file_name, 'w+') as file:
            file.write(res)

