#!/usr/bin/env python3
# # -*- coding: utf-8 -*-

import logging
import os

from rackMonitoring.devices import devices
from rackMonitoring.template import (
    rackmonitor_template,
    rackmonitor_template_bot,
    rackmonitor_template_top,
)

logger = logging.getLogger()
if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def generate(args, defaults):
    logger.info("Generating RackMonitoring.")
    dir_name = os.path.dirname(os.path.abspath(__file__))

    cmd_key = args.cmd_prefix

    for device in devices:

        res = ""

        res += rackmonitor_template_top.safe_substitute(
            defaults,
            IP_ADDR=device.ip,
            IP_ASYN_PORT=device.ip_asyn_port,
        )

        res += rackmonitor_template.safe_substitute(
            IP_ASYN_PORT=device.ip_asyn_port,
            PREFIX=device.prefix,
            SCAN_RATE=device.scan_rate,
        )

        res += rackmonitor_template_bot.safe_substitute(defaults)

        if not os.path.exists(os.path.join(dir_name, "server/cmd/")):
            os.makedirs(os.path.join(dir_name, "server/cmd/"))

        cmd_path = os.path.join(dir_name, "server/cmd/" + cmd_key + device.file_name)
        with open(cmd_path, "w+") as file:
            file.write(res)

        os.chmod(cmd_path, 0o774)
