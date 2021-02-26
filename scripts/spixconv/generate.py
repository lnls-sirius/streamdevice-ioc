#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
import os

from common.procCtrl import generate_st_cmd
from spixconv.cmd_template import top as template_top, bot as template_bot
from spixconv.devices import boards

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def write(dir_name, board, cmd_key, cmd_data):
    if not os.path.exists(os.path.join(dir_name, "server/cmd/")):
        os.makedirs(os.path.join(dir_name, "server/cmd/"))
    cmd_path = os.path.join(dir_name, f"server/cmd/{cmd_key}{board.file_name}")
    with open(cmd_path, "w+") as file:
        file.write(cmd_data)
    os.chmod(cmd_path, 0o664)


def generate_proc_ctrl(cmd_key, board, dir_name):
    """ Generate procServControl [{pv:..., ip:...}, ...] """
    iocs = []
    for board in boards:
        iocs.append(
            {
                "ip": f"/opt/streamdevice-ioc/sockets/{cmd_key}{board.ip}".replace(
                    ".", "_"
                ).replace(":", "_")
                + ".sock",
                "pv": f"ProcCtrl:{board.device}",
            }
        )
    generate_st_cmd(iocs, dir_name)


def generate(args, defaults):
    logger.info("Generating SPIxCONV.")
    dir_name = os.path.dirname(os.path.abspath(__file__))

    cmd_key = args.cmd_prefix

    for board in boards:
        cmd_data = ""

        cmd_data += template_top.safe_substitute(
            defaults,
            IP_ADDR=board.ip,
            DATABASE=board.database,
            SCAN_RATE=board.scan_rate,
            PREFIX=board.device,
            VOLTAGE_FACTOR=board.voltage_factor,
            DESCRIPTION=board.description,
            ADDRESS=board.address,
            DELAY=board.step_delay,
            TRIGGER=board.step_trigger,
        )
        cmd_data += template_bot.safe_substitute(defaults, PREFIX=board.device)

        write(dir_name=dir_name, board=board, cmd_key=cmd_key, cmd_data=cmd_data)

    generate_proc_ctrl(cmd_key=cmd_key, board=board, dir_name=dir_name)
