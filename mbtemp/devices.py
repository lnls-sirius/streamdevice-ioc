#!/usr/bin/python3
# -*- coding: utf-8 -*-
import logging
import pandas
import os
from common import DATA_MBTEMP

logger = logging.getLogger()

def get_device(addr, pv, chs=[]):
    for i in range(1, len(chs)):
        if not chs[i] or chs[i] == '':
            chs[i] = pv + ':' + str(i + 1)

    return {  # A device
        'MBTEMP_ADDRESS': addr,
        'PREFIX': pv,
        'channels': chs
    }


def get_sector(f_name, ip, devices):
    return {
        # A Sector
        'f_name': f_name + '.cmd',
        'SCAN_RATE': "2",
        'IP_ADDR': ip + ':4161',
        # Devices
        'devices': devices
    }

sectors = []
for _ip, rows in DATA_MBTEMP.items():
    if len(rows) > 32:
        logger.error(
            'More than 32 devices are set for the {} network. rows {}.'.format(_ip, rows))
        continue

    devs = []
    for row in rows:
        devs.append(get_device(
            row['ADDR'], row['Dev'],
            [row['CH1'], row['CH2'],
             row['CH3'], row['CH4'],
             row['CH5'], row['CH6'],
             row['CH7'], row['CH8']]))

    sectors.append(get_sector(_ip, _ip, devs))
