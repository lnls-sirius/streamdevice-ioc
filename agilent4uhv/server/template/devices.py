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

BASE_EPICS_CA_SERVER_PORT = 5070

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
        'Test', '10.0.6.67:4161', [
        get_device('D1', 1, ['D1:CH1', 'D1:CH2', 'D1:CH3', 'D1:CH4']),
        get_device('D2', 2, ['D2:CH1', 'D2:CH2', 'D2:CH3', 'D2:CH4']),
        get_device('D3', 3, ['D3:CH1', 'D3:CH2', 'D3:CH3', 'D3:CH4']),
        get_device('D4', 4, ['D4:CH1', 'D4:CH2', 'D4:CH3', 'D4:CH4'])
    ]) 
]
