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
    import argparse
    parser = argparse.ArgumentParser(description='PVs to be archived.')
    parser.add_argument('--mbtemp', help='Print MBTemp data', action='store_true')
    parser.add_argument('--mks', help='Print MKS data.', action='store_true')
    parser.add_argument('--uhv', help='Print 4UHV data.', action='store_true')
    args = parser.parse_args()

    if args.uhv:
        for k, vals in DATA_4UHV.items():
            for v in vals:
                for suf in agilent4uhv['device']:
                    print(v['Dispositivo'] + suf)
                for suf in agilent4uhv['ch']:
                    print(v['C1'] + suf)
                    print(v['C2'] + suf)
                    print(v['C3'] + suf)
                    print(v['C4'] + suf)
    if args.mks:
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
    if args.mbtemp:
        for k, vals in DATA_MBTEMP.items():
            for row in vals:
                print(row['Dev'] + ':Alpha')
                for ch in [row['CH1'], row['CH2'],
                        row['CH3'], row['CH4'],
                        row['CH5'], row['CH6'],
                        row['CH7'], row['CH8']]:
                    print(ch)
                    print(ch + '-Raw')