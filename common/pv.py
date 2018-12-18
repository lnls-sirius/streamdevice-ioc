#!/usr/bin/python3
import sys
from os import path
sys.path.append(path.join(path.dirname(path.abspath(__file__)),'../'))
from common import DATA_MBTEMP, DATA_4UHV, DATA_MKS

agilent4uhv = {
    'device': [
        ':Model-Cte',
        ':SerialNumber-Cte',
        ':FanTemperature-Mon',
        ':Protect-Mon',
        ':Step-Mon',
        ':Unit-RB',
        ':Unit-SP',
        ':Mode-RB',
        ':Mode-SP'],
    'ch':[
        ':Current-Mon',
        ':Pressure-Mon',
        ':Voltage-Mon',
        ':HVTemperature-Mon',
        ':ErrorCode-Mon',
        ':SetErrorCode-Mon',
        ':DeviceNumber-RB']
}

mks = {
    'device':[
        ':SerialNumber',
        ':CTLV',
        ':ModuleType-A',
        ':ModuleType-B',
        ':ModuleType-C',
        ':SensorType-A',
        ':SensorType-B',
        ':SensorType-C',
        ':Unit',
        ':UnitSp',
        ':Relay1:SetpointStatus-Mon',
        ':Relay2:SetpointStatus-Mon',
        ':Relay3:SetpointStatus-Mon',
        ':Relay4:SetpointStatus-Mon',
        ':Relay5:SetpointStatus-Mon',
        ':Relay6:SetpointStatus-Mon',
        ':Relay7:SetpointStatus-Mon',
        ':Relay8:SetpointStatus-Mon',
        ':Relay9:SetpointStatus-Mon',
        ':Relay10:SetpointStatus-Mon',
        ':Relay11:SetpointStatus-Mon',
        ':Relay12:SetpointStatus-Mon'
    ],
    'ch':[
        ':Pressure-Mon',
        ':Pressure-Mon-s',
        ':Enable-RB',
        ':Enable-SP'
    ]
}

if __name__=='__main__':
    for k, vals in DATA_4UHV.items():
        for v in vals:
            for suf in agilent4uhv['device']:
                print(v['Dispositivo'] + suf)
            for suf in agilent4uhv['ch']:
                print(v['C1'] + suf)
                print(v['C2'] + suf)
                print(v['C3'] + suf)
                print(v['C4'] + suf)

    for k, vals in DATA_MKS.items():
        for v in vals:
            for suf in mks['device']:
                print(v['Dispositivo'] + suf)
            for suf in mks['ch']:
                print(v['A1'] + suf)
                print(v['A2'] + suf)
                print(v['B1'] + suf)
                print(v['B2'] + suf)
                print(v['C1'] + suf)
                print(v['C2'] + suf)
