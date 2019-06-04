#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import pandas
import logging

from common import DATA_4UHV

logger = logging.getLogger()

def get_serial_addess(addr):
    return 128 + int(addr)

def get_device(prefix = None, address = 0, channels = [None,None,None,None], high = [0, 0, 0, 0], hihi = [0, 0, 0, 0]):
    if prefix == None:
        return None

    return {# A device
        'PREFIX' : str(prefix),
        'ADDRESS' : get_serial_addess(address),
        'channels': channels,
        'high' : high,
        'hihi' : hihi
    }

def get_sector(f_name = 'default_name', ip_address = "10.0.6.67", devices = [None, None, None, None], asyn_ip_port = 'IPPort0'):
    return {
        # A Sector
        'f_name' : f_name  + ':5004',
        'IP_ASYN_PORT' : asyn_ip_port,
        # Beaglebone IP.
        'IP_ADDR' : ip_address + ':5004',
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
        #HI C1	HI C2	HI C3	HI C4	HIHI C1	HIHI C2	HIHI C3	HIHI C4
        devs.append(get_device(row['Dispositivo'], row['RS485 ID'],
                        [row['C1'], row['C2'], row['C3'], row['C4']],
                        [row['HI C1'], row['HI C2'], row['HI C3'], row['HI C4']],
                        [row['HIHI C1'], row['HIHI C2'], row['HIHI C3'], row['HIHI C4']]))

    while len(devs) < 4:
        devs.append(None)

    sectors.append(get_sector(_ip, _ip ,devs))
