#!/usr/bin/python3
# -*- coding: utf-8 -*-
import logging
import pandas
import os

logger = logging.getLogger()
FILE = os.path.dirname(os.path.realpath(__file__)) + '/../../../Redes e Beaglebones.xlsx'
SHEET = 'PVs MBTemp'

sheet = pandas.read_excel(FILE, sheet_name=SHEET, dtype=str) 
sheet = sheet.replace('nan', '')

# IP	Setor	RS485 ID	Rack	Dispositivo	C1	C2	C3	C4
beagle = {}
for ip, rack, addr, dev, c1, c2 ,c3 ,c4, c5,c6,c7,c8\
        in zip(
            sheet['IP'], 
            sheet['Rack'],
            sheet['ADDR'],
            sheet['Dev'],
            sheet['CH1'],
            sheet['CH2'],
            sheet['CH3'],
            sheet['CH4'],
            sheet['CH5'],
            sheet['CH6'],
            sheet['CH7'],
            sheet['CH8'] 
        ):
    
    if ip == '':
        logger.error('Ip not set for {}'.format([ip, addr, rack, dev, c1, c2 ,c3 ,c4, c5,c6,c7,c8]))
        continue
    
    if ip in beagle:
        beagle[ip].append([ip, addr, rack, dev, c1, c2 ,c3 ,c4, c5,c6,c7,c8])
    else:
        beagle[ip] = [[ip, addr, rack, dev, c1, c2 ,c3 ,c4, c5,c6,c7,c8]]




def get_device(addr, pv, chs = []):
    for i in range(1, len(chs)):
        if not chs[i] or chs[i] == '':
            chs[i] = pv + ':' + str(i + 1)

    return {# A device
            'MBTEMP_ADDRESS' : addr,
            'PREFIX' : pv,
            'channels' : chs
    }

def get_sector(f_name, ip, devices):
    return {# A Sector
        'f_name' : f_name,
        'SCAN_RATE' : "2",
        'IP_ADDR' : ip + ':4161',
        # Devices
        'devices': devices
    }


sectors = []
for _ip, values in beagle.items():
    if len(values) > 32:
        logger.error('More than 32 devices are set for the {} network. Values {}.'.format(_ip, values))
        continue

    devs = []
    for val in values:
        devs.append(get_device(\
                        val[1], # ADDR
                        val[3], # Disp PV 
                        [val[4], val[5], val[4], val[7], val[7], val[8], val[10], val[11]])) # 1-8
    
    sectors.append(get_sector(_ip, _ip ,devs))

# sectors = [ # Sector list
#     get_sector(
#         "SALA1-BOOSTER.cmd",
#         "10.128.101.106:4161",
#         [
#             get_device('1', 'mbt-booster-1'),
#             get_device('2', 'mbt-booster-2'),
#             get_device('3', 'mbt-booster-3'),
#             get_device('4', 'mbt-booster-4'),
#             get_device('5', 'mbt-booster-5')
#         ]
#     ), 
#     get_sector(
#         "LTB.cmd",
#         "10.128.255.123:4161",
#         [
#             get_device('1', 'mbt-ltb-booster-1')
#         ]
#     )
# ]

