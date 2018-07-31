#!/usr/bin/env python
# -*- coding: utf-8 -*-

sectors = [ # Sector list
    {# A Sector
        'f_name' : "MKS927b_Sector1.cmd",
        'SCAN_RATE' : "10",
        'IP_ASYN_PORT' : "IPPort",
        
        # Devices
        'devices': [{# A device
            'IP_ADDR' : "10.0.6.63:4161",
            'PREFIX' : "VGC1"
        },{# A device
            'IP_ADDR' : "10.0.6.64:4161",
            'PREFIX' : "VGC2"
        },{# A device
            'IP_ADDR' : "10.0.6.65:4161",
            'PREFIX' : "VGC3"
        }]
    }
]

