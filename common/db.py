#!/usr/bin/python3
from string import Template

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

chain = ''

ch_prefix = ['$(PREFIX-CH1)','$(PREFIX-CH2)','$(PREFIX-CH3)','$(PREFIX-CH4)']
ch_records = [
    ['ai', 'Current-Mon'],
    ['ai', 'Pressure-Mon'],
    ['ai', 'Voltage-Mon'],
    ['longin', 'HVTemperature-Mon'],
    ['mbbi', 'ErrorCode-Mon'], 
    ['mbbi', 'HVState-RB'],
    ['ai', 'PowerMax-RB'],
    ['ai', 'CurrentProtect-RB'],
    ['ai', 'VoltageTarget-RB'],
    ['ai', 'Setpoint-RB']
]
device = [
    ['longin','FanTemperature-Mon'],
    ['longin','Protect-Mon'],
    ['longin','Step-Mon'],
    ['mbbi','Unit-RB'],
    ['bi','Mode-RB']
]

for _type, name in device:
    print(BASIC_RECORD.safe_substitute(type=_type, name="$(PREFIX):" + name,fields=''))
for prf in ch_prefix:
    for _type, name in ch_records:
        print(BASIC_RECORD.safe_substitute(type=_type, name=prf + ":" + name,fields=''))

