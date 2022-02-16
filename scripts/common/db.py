#!/usr/bin/env python3
import pandas
import logging

from string import Template
from common.consts import config

logger = logging.getLogger()


class DbData:
    def __init__(self, sheet_name, ip="IP", aditional_check=None):
        """
        :param sheet_name: xlsx sheet name.
        :param ip: column name containing the ip address.
        :param aditional_check: a function that receives row and sheet_name and returns True or False depending on the check result.
        """
        SPREADSHEET = config.get_spreadsheet()
        logger.info("Loading from '{}', sheet '{}'".format(SPREADSHEET, sheet_name))
        self.data = {}
        self.sheet = pandas.read_excel(SPREADSHEET, sheet_name=sheet_name, dtype=str)
        self.sheet = self.sheet.replace("nan", "")
        for _, row in self.sheet.iterrows():
            if row[ip] == "":
                continue

            if row["ENABLE"] != "True":
                logger.info("{}: {} DISABLED".format(sheet_name, row[ip]))
                continue

            if aditional_check and not aditional_check(row, sheet_name):
                continue

            if row[ip] in self.data:
                self.data[row[ip]].append(row)
            else:
                self.data[row[ip]] = [row]


FLNK = Template(
    """
    field(FLNK, "${name}")
    """
)
BASIC_RECORD = Template(
    """record(${type}, "${name}") {
    field(FLNK, "#######")${fields}
}"""
)


if __name__ == "__main__":
    chain = ""

    ch_prefix = ["$(PREFIX-CH1)", "$(PREFIX-CH2)", "$(PREFIX-CH3)", "$(PREFIX-CH4)"]
    ch_records = [
        ["ai", "Current-Mon"],
        ["ai", "Pressure-Mon"],
        ["ai", "Voltage-Mon"],
        ["longin", "HVTemperature-Mon"],
        ["mbbi", "ErrorCode-Mon"],
        ["mbbi", "HVState-RB"],
        ["ai", "PowerMax-RB"],
        ["ai", "CurrentProtect-RB"],
        ["ai", "VoltageTarget-RB"],
        ["ai", "Setpoint-RB"],
    ]
    device = [
        ["longin", "FanTemperature-Mon"],
        ["longin", "Protect-Mon"],
        ["longin", "Step-Mon"],
        ["mbbi", "Unit-RB"],
        ["bi", "Mode-RB"],
    ]

    for _type, name in device:
        print(
            BASIC_RECORD.safe_substitute(
                type=_type, name="$(PREFIX):" + name, fields=""
            )
        )
    for prf in ch_prefix:
        for _type, name in ch_records:
            print(
                BASIC_RECORD.safe_substitute(
                    type=_type, name=prf + ":" + name, fields=""
                )
            )
