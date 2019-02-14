#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import pandas
import logging

from common import DATA_4UHV

logger = logging.getLogger()

def get_serial_addess(addr):
    return 128 + int(addr)

def get_device(prefix = None, address = 0, channels = [None,None,None,None]):
    if prefix == None:
        return None

    return {# A device
        'PREFIX' : str(prefix),
        'ADDRESS' : get_serial_addess(address),
        'channels': channels
    }

def get_sector(f_name = 'default_name', ip_address = "10.0.6.67", devices = [None, None, None, None], asyn_ip_port = 'IPPort0'):
    return {
        # A Sector
        'f_name' : f_name  + ':4161',
        'IP_ASYN_PORT' : asyn_ip_port,
        # Beaglebone IP.
        'IP_ADDR' : ip_address + ':4161',
        # Devices
        'devices': devices
    }

sectors = []
for _ip, rows in DATA_4UHV.items():
    if len(rows) > 4:
        logger.error('More than 4 devices are set for the {} network. Values {}.'.format(_ip, rows))
        continue

    devs = []
    for row in rows:
        devs.append(get_device(row['Dispositivo'], row['RS485 ID'],
                        [row['C1'], row['C2'], row['C3'], row['C4']]))

    while len(devs) < 4:
        devs.append(None)

    sectors.append(get_sector(_ip, _ip ,devs))
