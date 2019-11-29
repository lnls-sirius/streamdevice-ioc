#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging

from countingPRU.consts import DATA_COUNTING_PRU

logger = logging.getLogger()


class CountingPRU:
    """
    Counting PRU model
    """

    def __init__(self, row=None):
        if row.empty:
            logger.error('Row not defined when creating CountingPRU object.')
            raise TypeError('Row undefined !')
        self.row = row
        self.ip = row['IP']
        self.device = row['Dev']
        self.channels = [row.get('CH{}'.format(i)) for i in range(1, 9)]
        self.descs = [row.get('CH{} DESC'.format(i)) for i in range(1, 9)]
        self.detectornames = [row.get('CH{} DEVICE'.format(i)) for i in range(1, 9)]
        self.scan_rate = '2 second'
        self.ip_asyn_port = 'IPPort0'
        self.file_name = self.ip + ':5000' + '.cmd'

    def __str__(self):
        return '< CountingPRU %s %s %s %s %s %s >' % (
        self.ip, self.device, self.channels, self.ip_asyn_port, self.file_name, self.scan_rate)


boards = []
for _ip, rows in DATA_COUNTING_PRU.items():
    if len(rows) != 1:
        logger.error('More than one Counting PRU is set for the same ip (%s) address !' % _ip)
        continue
    boards.append(CountingPRU(rows[0]))
