#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import pandas
import logging


logger = logging.getLogger()

'''
    For each sector a .cmd file will be generated.
    The ioc will run remotely.
    A beaglebone will be the bridge between the rs485 and the remote ioc.
    All devices must be connected via rs485.
    Each Agilent is a device.
    A maximum of 4 devices is supported.
    An ioc per rs485 network.
    If a channel or device will not be used, set it to None

'''
FILE = os.path.dirname(os.path.realpath(__file__)) + '/../../../Redes e Beaglebones.xlsx'
SHEET = 'PVs Agilent 4UHV'

sheet = pandas.read_excel(FILE, sheet_name=SHEET, dtype=str) 
sheet = sheet.replace('nan', '')

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
        'f_name' : f_name,
        'IP_ASYN_PORT' : asyn_ip_port,
        # Beaglebone IP. 
        'IP_ADDR' : ip_address + ':4161',
        # Devices
        'devices': devices
    }

beagle = {}
# IP	Setor	RS485 ID	Rack	Dispositivo	C1	C2	C3	C4
for index, row in sheet.iterrows():
    ip, sector, rs_id, rack, disp, c1, c2 ,c3 ,c4 = \
        row['IP'], row['Setor'], row['RS485 ID'], row['Rack'],\
        row['Dispositivo'],\
        row['C1'], row['C2'], row['C3'], row['C4']

    if ip == '':
        logger.error('Ip not set for {}'.format([ip, sector, rs_id, rack, disp, c1, c2 ,c3 ,c4]))
        continue
    
    if ip in beagle:
        beagle[ip].append([ip, sector, rs_id, rack, disp, c1, c2 ,c3 ,c4])
    else:
        beagle[ip] = [[ip, sector, rs_id, rack, disp, c1, c2 ,c3 ,c4]]

sectors = []
for _ip, values in beagle.items():
    if len(values) > 4:
        logger.error('More than 4 devices are set for the {} network. Values {}.'.format(_ip, values))
        continue

    devs = []
    for val in values:
        devs.append(get_device(\
                        val[4], # Disp PV 
                        val[2], # RS 485 ID
                        [val[5], val[6], val[7], val[8]])) # C1, C2, C3 e C4
    
    while len(devs) < 4:
        devs.append(None)

    sectors.append(get_sector(_ip, _ip ,devs))
