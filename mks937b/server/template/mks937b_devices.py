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

sectors = [ # Sector list
    {# A Sector
        'f_name' : "RingSubSector1",
        'SCAN_RATE' : "1",
        'IP_ASYN_PORT' : "IPPort0",
        'IP_ADDR' : "10.0.6.67:4161", # Beaglebone IP. 
        # Devices
        'devices': [{# A device
            'CONFIG': [CC, CC, PR],
            'PREFIX' : "VGC1",
            'ADDRESS' :'001',
            'pressures':[{ # Pressure readings (1 - 6)
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
        },{# A device
            'CONFIG': [CC, CC, PR],
            'PREFIX' : "VGC2",
            'ADDRESS' :'002',
            'pressures':[{ # Pressure readings (1 - 6)
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
        },{# A device
            'CONFIG': [CC, CC, PR],
            'PREFIX' : "VGC3",
            'ADDRESS' :'003',
            'pressures':[{ # Pressure readings (1 - 6)
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
        },{# A device
            'CONFIG': [CC, CC, PR],
            'PREFIX' : "VGC4",
            'ADDRESS' :'004',
            'pressures':[{ # Pressure readings (1 - 6)
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
        }]
    }
]
