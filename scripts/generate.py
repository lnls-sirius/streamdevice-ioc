#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
import argparse

from common.consts import config

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
    parser.add_argument(
        "--spreadsheet",
        help="XLSX name",
        default="./spreadsheet/Redes e Beaglebones.xlsx",
    )

    args = parser.parse_args()
    config.set_spreadsheet(args.spreadsheet)

    args.cmd_prefix = f"{args.device}-"
    defaults = {}

    if args.device == UHV:
        from agilent4uhv.generate import generate

        generate(args, defaults)

    elif args.device == MKS:
        from mks937b.generate import generate

        generate(args, defaults)
    elif args.device == PRU:
        from countingpru.generate import generate

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
