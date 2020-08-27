#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import logging

from agilent4uhv.cmd_template import (
    template_bot,
    template_channel,
    template_device,
    template_top,
)
from agilent4uhv.devices import sectors

from common.utils import deploy_files

logger = logging.getLogger()

SEC_PER_DEVICE = 2

if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def generate(args, defaults):
    logger.info("Generating Agilent 4UHV.")

    epics_ca_port_increase = args.epics_ca_port_increase
    epics_ca_server_port = args.base_epics_ca_port
    cmd_key = args.cmd_prefix

    dir_name = os.path.dirname(os.path.abspath(__file__))
    for sector in sectors:
        res = ""

        devices = sector["devices"]
        ip_asyn_port = sector["IP_ASYN_PORT"]
        ip_addr = sector["IP_ADDR"]
        devices_num = 0

        res += template_top.safe_substitute(
            defaults,
            IP_ADDR=ip_addr,
            IP_ASYN_PORT=ip_asyn_port,
            EPICS_CA_SERVER_PORT=epics_ca_server_port,
        )

        for i in range(4):
            if devices[i] is None:
                devices[i] = {"P": "None:{}".format(i)}
                continue
            devices_num += 1

        d_n = 0
        for device in devices:
            d_n += 1
            if device["P"].startswith("None"):
                continue

            prefix = device["P"]
            serial_address = device["ADDRESS"]

            channels = device["channels"]
            p_high = device["high"]
            p_hihi = device["hihi"]

            for i in range(4):
                if channels[i] is None:
                    channels[i] = "None:{}".format(i)

            res += template_device.safe_substitute(
                IP_ASYN_PORT=ip_asyn_port,
                P=prefix,
                ADDR=serial_address,
                P_CH1=channels[0],
                P_CH2=channels[1],
                P_CH3=channels[2],
                P_CH4=channels[3],
                DEVICE_NUM=d_n,
                TIME=devices_num * SEC_PER_DEVICE,
            )

            for i in range(4):
                if channels[i].startswith("None"):
                    continue

                res += template_channel.safe_substitute(
                    IP_ASYN_PORT=ip_asyn_port,
                    D=prefix,
                    P=channels[i],
                    P_HIGH=p_high[i],
                    P_HIHI=p_hihi[i],
                    ADDR=serial_address,
                    CH_NUM=i + 1,
                )
        if epics_ca_port_increase:
            epics_ca_server_port += 2
        res += template_bot.safe_substitute(defaults)

        if not os.path.exists(os.path.join(dir_name, "server/cmd/")):
            os.makedirs(os.path.join(dir_name, "server/cmd/"))

        cmd_path = os.path.join(
            dir_name, "server/cmd/" + cmd_key + sector["f_name"] + ".cmd"
        )
        with open(cmd_path, "w+") as file:
            file.write(res)

        os.chmod(cmd_path, 0o544)

    deploy_files(dir_name, defaults["TOP"])
