#!/usr/bin/python3
# -*- coding: utf-8 -*-
import logging
# import pandas
import os
from common import DATA_MBTEMP

logger = logging.getLogger()


class MBTempDevice():

    def __init__(self, row = None):

        if row.empty:
            logger.error('Row not defined when creating MBTemp device !')
            raise TypeError('Row undefined.')

        self.prefix = row['Dev']
        self.address = row['ADDR']
        self.channels = [row['CH{}'.format(c)] for c in range(1, 9)]
        for i in range(1, len(self.channels)):
            if not self.channels[i] or self.channels[i] == '':
                self.channels[i] = self.prefix + ':' + str(i + 1)

    def __str__(self):
        return '< MBTempDevice %s %s %s >' % (self.prefix, self.address, self.channels)

class MBTemp():
    def __init__(self, rows = None, ip = None):

        if rows == None:
            logger.error('Rows not defined when creating MBTemp.!')
            raise TypeError('Rows undefined.')
        if ip == None:
            logger.error('Ip not defined when creating MBTemp.!')
            raise TypeError('Ip undefined.')

        self.ip_asyn_port = 'IPPort0'
        self.rows = rows
        self.ip = ip + ':4161'
        self.file_name = self.ip + '.cmd'
        self.scan_rate = '2 second'

        self.devices  = []

        for row in rows:
            self.devices.append(MBTempDevice(row))

    def __str__(self):
        return '< MBTemp %s %s %s devices %s >' % (self.ip, self.file_name, self.scan_rate, len(self.devices))

boards = []
for _ip, rows in DATA_MBTEMP.items():
    if len(rows) > 32:
        logger.error('More than 32 devices are set for the {} network. rows {}.'.format(_ip, rows))
        continue

    boards.append(MBTemp(rows, _ip))
    logger.info('Adding a new %s.\n' % boards[-1])