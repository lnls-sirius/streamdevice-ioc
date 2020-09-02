#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging
import typing
from agilent4uhv.consts import DATA_4UHV

logger = logging.getLogger()


def get_serial_addess(addr):
    return 128 + int(addr)


class Device:
    def __init__(self, prefix, serial_address, channels):
        self.prefix: str = prefix
        self.serial_address: int = get_serial_addess(serial_address)
        self.channels = channels
        for i in range(len(self.channels)):
            if self.channels[i] is None or self.channels[i].strip() == "":
                self.channels[i] = ""
            else:
                self.channels[i] = self.channels[i].strip()



class DevicesNet:
    def __init__(self, ip_address, devices, asyn_ip_port="IPPort0"):
        self.f_name: str = ip_address + ":5004"
        self.ip_address: str = ip_address + ":5004"
        self.devices: typing.List = devices
        self.asyn_ip_port: str = asyn_ip_port

        self.devices_num: int = 0
        for device in self.devices:
            if device is None:
                continue
            self.devices_num += 1


sectors: typing.List[DevicesNet] = []
for _ip, rows in DATA_4UHV.items():
    if len(rows) > 4:
        logger.error(
            'More than 4 devices are set for the "{}" network. Values "{}".'.format(
                _ip, rows
            )
        )
        continue

    devs = []
    for row in rows:
        devs.append(
            Device(
                prefix=row["Dispositivo"],
                serial_address=row["RS485 ID"],
                channels=[row["C1"], row["C2"], row["C3"], row["C4"]],
            )
        )

    net = DevicesNet(_ip, devs)
    if net.devices_num == 0:
        logger.error(
            'Network "{}" has {} devices'.format(net.ip_address, net.devices_num)
        )
        continue
    sectors.append(net)
