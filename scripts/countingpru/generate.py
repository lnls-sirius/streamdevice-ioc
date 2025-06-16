#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
This template is used to generate the default .cmd iocBoot file.
The user should pass as parameter the destination file that will be generated.
"""
import logging
import os

from countingpru.devices import boards
from countingpru.template import template, template_bot, template_top

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def generate_device(board, defaults) -> str:
    res = ""
    res += template_top.safe_substitute(
        defaults,
        IP=board.ip,
        IP_ASYN_PORT=board.ip_asyn_port,
    )

    counting_device = board.device

    res += template.safe_substitute(
        IP_ASYN_PORT=board.ip_asyn_port,
        COUNTING_DEVICE=counting_device,
        SCAN_RATE=board.scan_rate,
        CH1=board.channels[0],
        CH2=board.channels[1],
        CH3=board.channels[2],
        CH4=board.channels[3],
        CH5=board.channels[4],
        CH6=board.channels[5],
        CH7=board.channels[6],
        CH8=board.channels[7],
        CH1_DESC=board.descs[0],
        CH2_DESC=board.descs[1],
        CH3_DESC=board.descs[2],
        CH4_DESC=board.descs[3],
        CH5_DESC=board.descs[4],
        CH6_DESC=board.descs[5],
        CH7_DESC=board.descs[6],
        CH8_DESC=board.descs[7],
        DETECTOR1_NAME=board.detectornames[0],
        DETECTOR2_NAME=board.detectornames[1],
        DETECTOR3_NAME=board.detectornames[2],
        DETECTOR4_NAME=board.detectornames[3],
        DETECTOR5_NAME=board.detectornames[4],
        DETECTOR6_NAME=board.detectornames[5],
        DETECTOR7_NAME=board.detectornames[6],
        DETECTOR8_NAME=board.detectornames[7],
    )

    res += template_bot.safe_substitute(defaults)
    return res


def generate(args, defaults):
    logger.info("Generating Counting PRU.")

    cmd_key = args.cmd_prefix

    dir_name = os.path.dirname(os.path.abspath(__file__))

    # CountingPRU specifics
    for board in boards:
        res = generate_device(board=board, defaults=defaults)
        if not os.path.exists(os.path.join(dir_name, "ioc/cmd")):
            os.makedirs(os.path.join(dir_name, "ioc/cmd"))

        cmd_path = os.path.join(dir_name, "ioc/cmd/" + cmd_key + board.file_name)
        with open(cmd_path, "w+") as file:
            file.write(res)
        os.chmod(cmd_path, 0o774)
