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
        get_device('BO-RA01:VA-SIPC-01', 1, ['BO-01U:VA-SIP20-BG', 'BO-01D:VA-SIP20-BG', 'BO-01D:VA-SIP20-ED', 'BO-02U:VA-SIP20-BG']),
        get_device('BO-RA01:VA-SIPC-02', 2, ['BO-02U:VA-SIP20-ED', 'BO-02D:VA-SIP20-ED', 'BO-03U:VA-SIP20-BG', 'BO-03U:VA-SIP20-ED']),
        None,
        None
    ]),
    get_sector(
        'S20-LTBB', '10.128.120.11:4161', [
        get_device('BO-RA20:VA-SIPC-01', 1, ['BO-48U:VA-SIP20-ED', 'BO-48D:VA-SIP20-ED', 'BO-49U:VA-SIP20-BG', 'BO-49U:VA-SIP20-ED']),
        get_device('BO-RA20:VA-SIPC-02', 2, ['BO-49D:VA-SIP20-ED', 'BO-50U:VA-SIP20-BG', 'BO-50U:VA-SIP20-ED', 'BO-50D:VA-SIP20-ED']),
        None,
        None
    ])
]
