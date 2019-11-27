#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging

from streamdeviceioc.spixconv.consts import DATA_SPIXCONV

logger = logging.getLogger()


class SPIxCONV():
    '''
    IP	Description	Dev	Voltage Factor	Address	Scan Rate	Database
    '''

    def __init__(self, row=None):
        if row.empty:
            logger.error('Row not defined when creating CountingPRU object.')
            raise TypeError('Row undefined !')
        self.row = row
        self.ip = row['IP'] + ':5005'
        self.device = row['Dev']
        self.address = row['Address']
        self.description = row['Description']
        self.voltage_factor = row['Voltage Factor']
        self.scan_rate = row['Scan Rate']
        self.database = row['Database']
        self.file_name = self.ip + '.cmd'

    def __str__(self):
        return '<SPIxCONV %s %s %s %s %s %s %s.db>' % (
            self.ip, self.device, self.description, self.voltage_factor, self.file_name, self.scan_rate, self.database)


boards = []
for _ip, rows in DATA_SPIXCONV.items():
    if len(rows) != 1:
        logger.error('More than one SPIxCONV is set for the same ip ({}) address !'.format(_ip))
        continue
    boards.append(SPIxCONV(rows[0]))
