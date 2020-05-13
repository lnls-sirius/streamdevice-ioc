#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging

from rackMonitoring.consts import DATA_RACKMONITORING

logger = logging.getLogger()



class RackMonitoring():
    def __init__(self, row=None, ip=None):
        
        self.prefix = row[0]['Dev']
        self.ip_asyn_port = 'IPPort0'
        self.ip = ip + ':5006'
        self.file_name = self.ip + '.cmd'
        self.scan_rate = '2 second'

    def __str__(self):
        return '< RackMonitoringDevice %s %s %s >' % (self.prefix, self.ip, self.file_name)


devices = []
for _ip, rows in DATA_RACKMONITORING.items():
    devices.append(RackMonitoring(rows, _ip))
