#!/usr/bin/python3
# -*- coding: utf-8 -*-
import pandas
import os
import logging

from common import DATA_MKS

logger = logging.getLogger()
CC = 'CC'
PR = 'PR'

def get_device(prefix, addr, config = [CC, CC, PR], gauges =  ['G1', 'G2', 'G3', 'G4', 'G5', 'G6'], pressures = None):
    return {# A device
        'CONFIG' : config,
        'PREFIX' : prefix,
        'ADDRESS' : addr,
        'pressures' : pressures,
        'GAUGES': gauges
    }

def get_sector(f_name, ip_addr, devices, ip_asyn_port = 'IPPort0', scan = '1'):
    return {# A Sector
        'f_name' : f_name,
        'IP_ADDR' : ip_addr, # Beaglebone IP.
        'SCAN_RATE' : scan,
        'IP_ASYN_PORT' : ip_asyn_port,
        # Devices
        'devices': devices
    }

sectors = []
for _ip, values in DATA_MKS.items():
    if len(values) > 32:
        logger.error('More than 32 devices are set for the {} network. Values {}.'.format(_ip, values))
        continue

    devs = []
    for val in values:
        devs.append(get_device(\
                        val['Dispositivo'],
                        val['RS485 ID'].zfill(3), val['Configuracao'].split(' '),
                        [val['A1'], val['A2'], val['B1'], val['B2'], val['C1'], val['C2']],
                        [
                            {'HI':val['HI A1'],'HIHI': val['HIHI A1']},
                            {'HI':val['HI A2'],'HIHI': val['HIHI A2']},
                            {'HI':val['HI B1'],'HIHI': val['HIHI B1']},
                            {'HI':val['HI B2'],'HIHI': val['HIHI B2']},
                            {'HI':val['HI C1'],'HIHI': val['HIHI C1']},
                            {'HI':val['HI C2'],'HIHI': val['HIHI C2']}
                        ]))

    sectors.append(get_sector(_ip + ":4161", _ip + ":4161" ,devs))
