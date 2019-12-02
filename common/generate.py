#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import logging
import argparse

sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../'))
logger = logging.getLogger()

UHV = 'UHV'
MKS = 'MKS'
PRU = 'PRU'
MBTemp = 'MBTemp'
SPIxCONV = 'SPIxCONV'

DEVICES = [UHV, MBTemp, PRU, SPIxCONV, MKS]

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate IOC files.',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--device', help='Device in use.', choices=DEVICES, required=True)
    parser.add_argument('--epics-base', help='Epics base path.', required=True)
    parser.add_argument('--asyn', help='Asyn driver path.', required=True)
    parser.add_argument('--top', help='StreamDevice path.', required=True)
    parser.add_argument('--arch', help='System architecture.', choices=['linux-x86_64', 'linux-arm'],
                        default='linux-x86_64')
    parser.add_argument('--epics-ca-port-increase', help='Increase EPICS_CA_SERVER_PORT by 2 for each deployed IOC.',
                        default=False, action='store_true')
    parser.add_argument('--base-epics-ca-port',
                        help='Initial EPICS CA server port. It will increase by 2 for every ioc.', type=int,
                        default=5064)
    parser.add_argument('--epics-caputlog-addr', default='0.0.0.0', help='EPICS Caputlog remote address.')
    parser.add_argument('--epics-caputlog-port', default='7011', help='EPICS Caputlog remote port.')
    parser.add_argument('--epics-log-addr', default='0.0.0.0', help='EPICS Log remote address.')
    parser.add_argument('--epics-log-port', default='7011', help='EPICS Log remote port.')
    args = parser.parse_args()

    args.cmd_prefix = args.device + '-'

    defaults = {
        'CD': '${TOP}', 'TOP': args.top, 'ASYN': args.asyn, 'ARCH': args.arch, 'EPICS_BASE': args.epics_base,
        'STREAM_PROTOCOL_PATH': '$(TOP)/protocol', 'LOG_ADDR': args.epics_log_addr, 'LOG_PORT': args.epics_log_port,
        'CAPUTLOG_ADDR': args.epics_caputlog_addr, 'CAPUTLOG_PORT': args.epics_caputlog_port
    }

    if args.device == UHV:
        from agilent4uhv.generate import generate
        generate(args, defaults)
    elif args.device == MKS:
        from mks937b.generate import generate
        generate(args, defaults)
    elif args.device == PRU:
        from countingPRU.generate import generate
        generate(args, defaults)
    elif args.device == MBTemp:
        from mbtemp.generate import generate
        generate(args, defaults)
    elif args.device == SPIxCONV:
        from spixconv.generate import generate
        generate(args, defaults)
