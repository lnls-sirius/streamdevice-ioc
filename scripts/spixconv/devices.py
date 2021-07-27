#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging
import typing

from spixconv.consts import DATA_SPIXCONV

logger = logging.getLogger()


class SPIxCONV:
    """
    IP    Description    Dev    Voltage Factor    Address    Scan Rate    Database
    """

    def __init__(self, row=None):
        if row.empty:
            logger.error("Row not defined when creating CountingPRU object.")
            raise TypeError("Row undefined !")
        self.row = row
        self.ip: str = row["IP"] + ":5005"
        self.device: str = row["Dev"]
        self.address: str = row["Address"]
        self.description: str = row["Description"]
        self.voltage_factor = row["Voltage Factor [V]"]
        self.scan_rate = row["Scan Rate"]
        self.database: str = row["Database (soft IOC)"]
        self.service_name = self.device.strip().replace(":", "--")
        self.file_name: str = f"{self.service_name}.cmd"
        self.step_trigger = row["Steps trigger [V]"]
        self.step_delay = row["Steps delay [s]"]

    def __str__(self):
        return "<SPIxCONV %s %s %s %s %s %s %s.db>" % (
            self.ip,
            self.device,
            self.description,
            self.voltage_factor,
            self.file_name,
            self.scan_rate,
            self.database,
        )


boards: typing.List[SPIxCONV] = []
for _ip, rows in DATA_SPIXCONV.items():
    if len(rows) != 1:
        logger.error(
            "More than one SPIxCONV is set for the same ip ({}) address !".format(_ip)
        )
        continue
    boards.append(SPIxCONV(rows[0]))
