#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import logging
import typing

from agilent4uhv.cmd_template import (
    template_bot,
    template_channel,
    template_device,
    template_top,
    template_autosave_chrestore,
    template_autosave_chmonitor,
)
from agilent4uhv.devices import sectors

logger = logging.getLogger()

SEC_PER_DEVICE = 2

if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def generate_device_specific(
    device, device_number: int, ip_asyn_port: str, sector
) -> typing.Tuple[str, str]:
    """
    @return a tuple containing the device and the autosave strings
    """
    res = ""
    _as = ""
    prefix = device.prefix
    serial_address = device.serial_address

    channels = device.channels

    for i in range(4):
        if channels[i] is None:
            # @todo: If the channel is empty do something....
            channels[i] = "None:{}".format(i)

    res += template_device.safe_substitute(
        IP_ASYN_PORT=ip_asyn_port,
        P=prefix,
        ADDR=serial_address,
        P_CH1=channels[0],
        P_CH2=channels[1],
        P_CH3=channels[2],
        P_CH4=channels[3],
        E_CH1="#" if channels[0] == "" else "",
        E_CH2="#" if channels[1] == "" else "",
        E_CH3="#" if channels[2] == "" else "",
        E_CH4="#" if channels[3] == "" else "",
        DEVICE_NUM=str(device_number),
        TIME=sector.devices_num * SEC_PER_DEVICE,
    )

    for i in range(4):
        if channels[i] == "":
            continue

        res += template_channel.safe_substitute(
            IP_ASYN_PORT=ip_asyn_port,
            D=prefix,
            P=channels[i],
            ADDR=serial_address,
            CH_NUM=i + 1,
        )

        # autosave restore
        _as += channels[i] + ":Pressure-Mon.HIHI\n"
        _as += channels[i] + ":Pressure-Mon.HIGH\n"

    return res, _as


def generate(args, defaults):
    logger.info("Generating Agilent 4UHV.")

    cmd_key = args.cmd_prefix

    dir_name = os.path.dirname(os.path.abspath(__file__))
    for sector in sectors:
        res = ""
        _as = ""

        devices = sector.devices
        ip_asyn_port = sector.asyn_ip_port
        ip_addr = sector.ip_address

        # autosave (autosave_ip_name)
        target_device_ip = ip_addr.replace(".", "_")

        # cmd top
        res += template_top.safe_substitute(
            defaults,
            IP_ADDR=ip_addr,
            IP_ASYN_PORT=ip_asyn_port,
        )

        # Device specific
        d_n = 0
        for device in devices:
            d_n += 1
            device_res, device_as = generate_device_specific(
                device=device,
                device_number=d_n,
                ip_asyn_port=ip_asyn_port,
                sector=sector,
            )
            res += device_res
            _as += device_as

        res += template_autosave_chrestore.safe_substitute(IP_ADDR=target_device_ip)

        # iocBoot
        res += template_bot.safe_substitute(defaults)

        # autosave monitors
        res += template_autosave_chmonitor.safe_substitute(IP_ADDR=target_device_ip)

        # Generate iocBoot .cmd files
        if not os.path.exists(os.path.join(dir_name, "ioc/cmd/")):
            os.makedirs(os.path.join(dir_name, "ioc/cmd/"))
        cmd_path = os.path.join(dir_name, "ioc/cmd/" + cmd_key + sector.f_name + ".cmd")

        with open(cmd_path, "w+") as _f:
            _f.write(res)
        os.chmod(cmd_path, 0o774)

        # Generate autosave .req files
        if not os.path.exists(os.path.join(dir_name, "ioc/autosave/")):
            os.makedirs(os.path.join(dir_name, "ioc/autosave/"))
        with open(
            os.path.join(dir_name, "ioc/autosave/" + target_device_ip + ".req"), "w+"
        ) as _f:
            _f.write(_as)
