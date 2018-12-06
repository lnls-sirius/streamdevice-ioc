#!/usr/bin/python3
# -*- coding: utf-8 -*-
import pandas
import os
import logging

logger = logging.getLogger()
CC = 'CC'
PR = 'PR'

FILE = os.path.dirname(os.path.realpath(__file__)) + '/../../../Redes e Beaglebones.xlsx'
SHEET = 'PVs MKS937b'

sheet = pandas.read_excel(FILE, sheet_name=SHEET, dtype=str) 
sheet = sheet.replace('nan', '')
'''
    For each sector a .cmd file will be generated.
    The ioc will run remotely.
    A beaglebone will be the bridge between the rs485 and the remote ioc.
    All devices must be connected via rs485.
    Each MKS is a device.

    IP Setor RS485 ID	Rack Dispositivo
    A1 A2	B1 B2 C1 C2	
    Configuracao	
    HI A1 HI A2	HI B1	HI B2	HI C1	HI C2	
    HIHI A1	HIHI A2	HIHI B1	HIHI B2	HIHI C1	HIHI C2
'''
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
        'IP_ADDR' : ip_addr + ":4161", # Beaglebone IP. 
        'SCAN_RATE' : scan,
        'IP_ASYN_PORT' : ip_asyn_port,
        # Devices
        'devices': devices
    }

beagle = {}
# IP Setor RS485 ID	Rack Dispositivo
# A1 A2	B1 B2 C1 C2	
# Configuracao	
# HI A1 HI A2	HI B1	HI B2	HI C1	HI C2	
# HIHI A1	HIHI A2	HIHI B1	HIHI B2	HIHI C1	HIHI C2
for index, row in sheet.iterrows():
    if row['IP'] == '':
        logger.error('Ip not set for {}'.format(row))
        continue
    if row['Configuracao'] == '':
        logger.error('Configuration not set for {}'.format(row))
        continue

    if row['IP'] in beagle:
        beagle[row['IP']].append(row)
    else:
        beagle[row['IP']] = [row]

sectors = []

for _ip, values in beagle.items():
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
    
    sectors.append(get_sector(_ip, _ip ,devs))
