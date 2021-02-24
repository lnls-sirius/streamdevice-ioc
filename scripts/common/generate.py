#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import logging
import argparse

sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../"))
logger = logging.getLogger()

UHV = "UHV"
MKS = "MKS"
PRU = "PRU"
MBTemp = "MBTemp"
SPIxCONV = "SPIxCONV"
RackMonitoring = "RackMonitoring"

DEVICES = [UHV, MBTemp, PRU, SPIxCONV, MKS, RackMonitoring]

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate IOC files.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "--device", help="Device in use.", choices=DEVICES, required=True
    )

    args = parser.parse_args()
    args.cmd_prefix = args.device + "-"

    defaults = {
        "CD": "${TOP}",
        "STREAM_PROTOCOL_PATH": "$(TOP)/protocol",
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
    elif args.device == RackMonitoring:
        from rackMonitoring.generate import generate

        generate(args, defaults)
