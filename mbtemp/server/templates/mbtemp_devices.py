#!/usr/bin/env python
# -*- coding: utf-8 -*-

sectors = [ # Sector list
    {# A Sector
        'f_name' : "MBTempSector1.cmd",
        'SCAN_RATE' : "2",

        # Devices
        'devices': [{# A device
            'IP_ADDR' : "10.0.6.63:4161",
            'MBTEMP_ADDRESS' : "8",
            'PREFIX' : "MBT1:MBTemp"
        },{# A device
            'IP_ADDR' : "10.0.6.64:4161",
            'MBTEMP_ADDRESS' : "1",
            'PREFIX' : "MBT2:MBTemp"
        },{# A device
            'IP_ADDR' : "10.0.6.65:4161",
            'MBTEMP_ADDRESS' : "3",
            'PREFIX' : "MBT3:MBTemp"
        }]
    },{# A Sector
        'f_name' : "MBTempSector2.cmd",
        'SCAN_RATE' : "2",

        # Devices
        'devices': [{# A device
            'IP_ADDR' : "10.0.7.63:4161",
            'MBTEMP_ADDRESS' : "8",
            'PREFIX' : "MBT1:MBTemp"
        },{# A device
            'IP_ADDR' : "10.0.7.64:4161",
            'MBTEMP_ADDRESS' : "1",
            'PREFIX' : "MBT2:MBTemp"
        },{# A device
            'IP_ADDR' : "10.0.7.65:4161",
            'MBTEMP_ADDRESS' : "3",
            'PREFIX' : "MBT3:MBTemp"
        }]
    }
]

