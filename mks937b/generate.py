#!/usr/bin/python3
# -*- coding: utf-8 -*-
import sys
import time
import logging
import argparse

from os import environ, path
from string import Template
sys.path.append(path.join(path.dirname(path.abspath(__file__)),'../'))

from mks937b.template import template_device, template_bot,\
                        template_top, template_pressure, template_cc,\
                        template_relay

from mks937b.devices import sectors  as sectors, CC, PR
from mks937b.proto_template import mks937b_pressures_proto
from mks937b.db_template import relay as db_relay

logger = logging.getLogger()
if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Generate MKS 937b IOC files.')
    parser.add_argument('--epics-ca-port-increase', help='Increase EPICS_CA_SERVER_PORT by 2 for each deployed IOC.', action='store_true')
    parser.add_argument('--base-epics-ca-port', help='Initial EPICS CA server port. It will increase by 2 for every ioc.', type=int, default=5064)
    parser.add_argument('--cmd-prefix', default='mks', help='Prefix for the .cmd files.')
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

    rel_db = ''
    rel_db += '''
    ################################################################################
    # Automatically generated content.
    # Changes on this file won't be persisted.
    # If the user wishes to modify it's content, change the template instead.
    ################################################################################
    '''
    for relay in range(1, 13):
        rel_db += db_relay.safe_substitute(RELAY=relay)

    with open('server/db/mks937b_relay.db', 'w+') as file:
        file.write(rel_db)

    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    CD = "${TOP}"

    for sector in sectors:
        res = ''
        count = 0

        name = CMD_KEY + sector['f_name']
        base_proto_name   =  name

        devices      = sector['devices']
        IP_ASYN_PORT = sector['IP_ASYN_PORT']
        SCAN_RATE    = sector['SCAN_RATE']
        IP_ADDR      = sector['IP_ADDR']

        res += template_top.safe_substitute(
                CD=CD,
                EPICS_BASE=EPICS_BASE,
                ASYN=ASYN,
                TOP=TOP,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
                IP_ADDR=IP_ADDR,
                IP_ASYN_PORT=IP_ASYN_PORT,
                EPICS_CA_SERVER_PORT=EPICS_CA_SERVER_PORT,
        )


        for device in devices:
            if device:
                CONFIG = device['CONFIG']
                PREFIX = device['PREFIX']
                ADDRESS= device['ADDRESS']
                pressures = device['pressures']
                GAUGES = device['GAUGES']
                proto_name = base_proto_name + 'ADDR' + ADDRESS

                cc_array = []
                if  CONFIG[0] == CC:
                    cc_array.append(0)
                if  CONFIG[1] == CC:
                    cc_array.append(2)
                if  CONFIG[2] == CC:
                    cc_array.append(4)

                res += template_device.safe_substitute(
                    IP_ASYN_PORT=IP_ASYN_PORT,
                    PREFIX=PREFIX,
                    SCAN_RATE=SCAN_RATE,
                    ADDRESS=ADDRESS,
                    G1=GAUGES[0],
                    G2=GAUGES[1],
                    G3=GAUGES[2],
                    G4=GAUGES[3],
                    G5=GAUGES[4],
                    G6=GAUGES[5],
                    P_PROTO=proto_name
                )
                with open('server/protocol/' + proto_name + '.proto', 'w+') as file:
                    file.write(
                        mks937b_pressures_proto.safe_substitute(
                        G1=GAUGES[0],
                        G2=GAUGES[1],
                        G3=GAUGES[2],
                        G4=GAUGES[3],
                        G5=GAUGES[4],
                        G6=GAUGES[5]))

                for channel in range(0, 6):
                    res += template_pressure.safe_substitute(
                        IP_ASYN_PORT=IP_ASYN_PORT,
                        PREFIX=GAUGES[channel],
                        ADDRESS=ADDRESS,
                        P_HI=pressures[channel].get('HI'),
                        P_HIHI=pressures[channel].get('HIHI'),
                        CHANNEL=channel+1
                    )
                for channel in cc_array:
                    res += template_cc.safe_substitute(
                        IP_ASYN_PORT=IP_ASYN_PORT,
                        PREFIX=GAUGES[channel],
                        ADDRESS=ADDRESS,
                        CHANNEL=channel+1)

                res += template_relay.safe_substitute(
                    IP_ASYN_PORT=IP_ASYN_PORT,
                    PREFIX=PREFIX,
                    ADDRESS=ADDRESS)

                res += '\n'
            count += 1

        if EPICS_CA_PORT_INCRESE:
            EPICS_CA_SERVER_PORT += 2

        res += template_bot

        with open('server/cmd/' + name + '.cmd', 'w+') as file:
            file.write(res)
