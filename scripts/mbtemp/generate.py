#!/usr/bin/env python3
# # -*- coding: utf-8 -*-

import logging
import os

from mbtemp.devices import boards
from mbtemp.template import mbt_template, mbt_template_bot, mbt_template_top

logger = logging.getLogger()
if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def generate_board(board, defaults) -> str:
    count = 0
    res = ""
    res += mbt_template_top.safe_substitute(
        defaults,
        IP_ADDR=board.ip,
        IP_ASYN_PORT=board.ip_asyn_port,
    )

    for device in board.devices:
        res += mbt_template.safe_substitute(
            IP_ASYN_PORT=board.ip_asyn_port,
            MBTEMP_ADDRESS=device.address,
            PREFIX=device.prefix,
            SCAN_RATE=board.scan_rate,
            SCAN_RATE_DEVICE="10 second",
            CH1=device.channels[0],
            CH2=device.channels[1],
            CH3=device.channels[2],
            CH4=device.channels[3],
            CH5=device.channels[4],
            CH6=device.channels[5],
            CH7=device.channels[6],
            CH8=device.channels[7],
        )

        count += 1

    res += mbt_template_bot.safe_substitute(defaults)
    return res


def generate(args, defaults):
    logger.info("Generating MBTemp.")
    dir_name = os.path.dirname(os.path.abspath(__file__))

    cmd_key = args.cmd_prefix

    # MBTemp specifics
    for board in boards:
        res = generate_board(board, defaults)

        if not os.path.exists(os.path.join(dir_name, "ioc/cmd/")):
            os.makedirs(os.path.join(dir_name, "ioc/cmd/"))

        cmd_path = os.path.join(dir_name, "ioc/cmd/" + cmd_key + board.file_name)
        with open(cmd_path, "w+") as file:
            file.write(res)

        os.chmod(cmd_path, 0o774)
