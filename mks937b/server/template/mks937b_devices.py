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

def get_device(prefix, addr, config = [CC, CC, PR], pressures = DEFAULT_ALARMS):
    return {# A device
        'CONFIG' : config,
        'PREFIX' : prefix,
        'ADDRESS' : addr,
        'pressures' : DEFAULT_ALARMS
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
    get_sector('S1-BOOSTER', '10.128.101.10:4161',[
        get_device('S1-BOOSTER-1', '001', [CC, CC, PR]),
        None,
        None,
        None
    ]),
    get_sector('S20-LTBOOSTER', '10.128.120.10:4161',[
        get_device('S20-LTB-1', '001', [CC, CC, PR]),
        get_device('S20-BOOSTER-1', '002', [CC, CC, PR]),
        None,
        None
    ])
]
