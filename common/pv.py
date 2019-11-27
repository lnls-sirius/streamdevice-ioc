#!/usr/bin/env python3
import sys
from os import path
sys.path.append(path.join(path.dirname(path.abspath(__file__)),'../'))
from common import DATA_MBTEMP, DATA_4UHV, DATA_MKS, DATA_COUNTING_PRU

agilent4uhv = {
    'device': [
        ':Model-Cte',
        ':SerialNumber-Cte',
        ':FanTemperature-Mon',
        ':Protect-RB',
        ':Step-RB',
        ':Step-SP',
        ':Unit-RB',
        ':Unit-SP',
        ':Autostart-RB',
        ':Autostart-SP'
        ],
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
        ':Relay1:Status-SP',
        ':Relay2:Status-SP',
        ':Relay3:Status-SP',
        ':Relay4:Status-SP',
        ':Relay5:Status-SP',
        ':Relay6:Status-SP',
        ':Relay7:Status-SP',
        ':Relay8:Status-SP',
        ':Relay9:Status-SP',
       ':Relay10:Status-SP',
       ':Relay11:Status-SP',
       ':Relay12:Status-SP',
        ':Relay1:Status-RB',
        ':Relay2:Status-RB',
        ':Relay3:Status-RB',
        ':Relay4:Status-RB',
        ':Relay5:Status-RB',
        ':Relay6:Status-RB',
        ':Relay7:Status-RB',
        ':Relay8:Status-RB',
        ':Relay9:Status-RB',
       ':Relay10:Status-RB',
       ':Relay11:Status-RB',
       ':Relay12:Status-RB',
        ':Relay1:Setpoint-SP',
        ':Relay2:Setpoint-SP',
        ':Relay3:Setpoint-SP',
        ':Relay4:Setpoint-SP',
        ':Relay5:Setpoint-SP',
        ':Relay6:Setpoint-SP',
        ':Relay7:Setpoint-SP',
        ':Relay8:Setpoint-SP',
        ':Relay9:Setpoint-SP',
       ':Relay10:Setpoint-SP',
       ':Relay11:Setpoint-SP',
       ':Relay12:Setpoint-SP',
        ':Relay1:Setpoint-RB',
        ':Relay2:Setpoint-RB',
        ':Relay3:Setpoint-RB',
        ':Relay4:Setpoint-RB',
        ':Relay5:Setpoint-RB',
        ':Relay6:Setpoint-RB',
        ':Relay7:Setpoint-RB',
        ':Relay8:Setpoint-RB',
        ':Relay9:Setpoint-RB',
       ':Relay10:Setpoint-RB',
       ':Relay11:Setpoint-RB',
       ':Relay12:Setpoint-RB',
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
    parser.add_argument('--counting_pru', help='Print Counting PRU data.', action='store_true')
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

    if args.counting_pru:
        for f, vals in DATA_COUNTING_PRU.items():
            if len(vals) == 1:
                row = vals[0]
                print(row['Dev'] + ':TimeBase')
                for ch in [row.get('CH{}'.format(i)) for i in range(1,9)]:
                    print(ch)
