#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
    For each sector a .cmd file will be generated.
    The ioc will run remotely.
    A beaglebone will be the bridge between the rs485 and the remote ioc.
    All devices must be connected via rs485.
    Each MKS is a device.
'''
CC = 'CC'
PR = 'PR'

DEFAULT_ALARMS = [
    { # Pressure readings (1 - 6)
        # Pressure 1
        'HI':'1e-7',
        'HIHI': '1e-5'
    },{# Pressure 2
        'HI':'1e-7',
        'HIHI': '1e-5'
    },{# Pressure 3
        'HI':'1e-7',
        'HIHI': '1e-5'
    },{# Pressure 4
        'HI':'1e-7',
        'HIHI': '1e-5'
    },{# Pressure 5
        'HI':'1e-7',
        'HIHI': '1e-5'
    },{# Pressure 6
        'HI':'1e-7',
        'HIHI': '1e-5'
}]

def get_device(prefix, addr, config = [CC, CC, PR], gauges =  ['G1', 'G2', 'G3', 'G4', 'G5', 'G6'], pressures = DEFAULT_ALARMS):
    return {# A device
        'CONFIG' : config,
        'PREFIX' : prefix,
        'ADDRESS' : addr,
        'pressures' : DEFAULT_ALARMS,
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

sectors = [ # Sector list
    get_sector('S1-Booster', '10.128.101.10:4161',[
        get_device('BO-RA01:VA-VGC-01', '001', [CC, CC, PR], ['BO-01U:VA-CCG-BG', 'm1g2', 'BO-04U:VA-CCG-BG', 'm1g4', 'BO-01U:VA-PIR-BG', 'BO-04U:VA-PIR-BG'])
        # get_device('VGC2', '002', [CC, CC, PR], ['VGC2:G1', 'VGC2:G2', 'VGC2:G3', 'VGC2:G4', 'VGC2:G5', 'VGC2:G6']),
        # get_device('VGC3', '003', [CC, CC, PR], ['VGC3:G1', 'VGC3:G2', 'VGC3:G3', 'VGC3:G4', 'VGC3:G5', 'VGC3:G6']),
        # get_device('VGC4', '004', [CC, CC, PR], ['VGC4:G1', 'VGC4:G2', 'VGC4:G3', 'VGC4:G4', 'VGC4:G5', 'VGC4:G6'])
    ])
]
