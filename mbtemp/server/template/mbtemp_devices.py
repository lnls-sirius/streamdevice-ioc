#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
sala1 - 5 mbt -> 10.128.101.14

ltb - 1 mbt -> 10.128.255.10
"""

def get_device(addr, pv):
    return {# A device
            'MBTEMP_ADDRESS' : addr,
            'PREFIX' : pv
    }
def get_sector(f_name, ip, devices):
    return {# A Sector
        'f_name' : f_name,
        'SCAN_RATE' : "2",
        'IP_ADDR' : ip,
        # Devices
        'devices': devices
    }

sectors = [ # Sector list
    get_sector(
        "SALA1-BOOSTER.cmd",
        "10.128.101.14:4161",
        [
            get_device('1', 'mbt-booster-1'),
            get_device('2', 'mbt-booster-2'),
            get_device('3', 'mbt-booster-3'),
            get_device('4', 'mbt-booster-4'),
            get_device('5', 'mbt-booster-5')
        ]
    ), 
    get_sector(
        "LTB.cmd",
        "10.128.255.10:4161",
        [
            get_device('1', 'mbt-ltb-booster-1')
        ]
    )
]

