#!/usr/bin/env python3
# -*- coding: utf-8 -*-

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

def get_serial_addess(addr):
    return 128 + addr

def get_device(prefix = None, address = 0, channels = [None,None,None,None]):
    if prefix == None:
        return None
    return {# A device
        'PREFIX' : str(prefix),
        'ADDRESS' : get_serial_addess(address),
        'channels': channels
    }

def get_sector(f_name = 'default_name', ip_address = "10.0.6.67:4161", devices = [None, None, None, None], asyn_ip_port = 'IPPort0'):
    return {
        # A Sector
        'f_name' : f_name,
        'IP_ASYN_PORT' : asyn_ip_port,
        # Beaglebone IP. 
        'IP_ADDR' : ip_address,
        # Devices
        'devices': devices
    }

sectors = [ # Sector list
    get_sector(
        'S1-BOOSTER', '10.128.101.11:4161', [
        get_device('S1-BOOSTER-1', 1, ['S1-BOOSTER-1:CH1', 'S1-BOOSTER-1:CH2', 'S1-BOOSTER-1:CH3', 'S1-BOOSTER-1:CH4']),
        get_device('S1-BOOSTER-2', 2, ['S1-BOOSTER-2:CH1', 'S1-BOOSTER-2:CH2', 'S1-BOOSTER-2:CH3', 'S1-BOOSTER-2:CH4']),
        None,
        None
    ]),
    get_sector(
        'S20-LTBB', '10.128.120.11:4161', [
        get_device('S20-LTB-1', 1, ['S20-LTB-1:CH1', 'S20-LTB-1:CH2', 'S20-LTB-1:CH3', 'S20-LTB-1:CH4']),
        get_device('S20-LTB-2', 2, ['S20-LTB-2:CH1', 'S20-LTB-2:CH2', 'S20-LTB-2:CH3', 'S20-LTB-2:CH4']),
        get_device('S20-BOOSTER-3', 3, ['S20-BOOSTER-1:CH1', 'S20-BOOSTER-1:CH2', 'S20-BOOSTER-1:CH3', 'S20-BOOSTER-1:CH4']),
        None
    ])
]
