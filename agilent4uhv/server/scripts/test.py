#!/usr/bin/python3
import time
from epics import camonitor 

ts1 = ""
ts2 = ""

def cab_func():
    pass

camonitor('Ag:Ch4:Voltage-Mon', callback=cab_func)
camonitor('Ag:Ch1:Current-Mon', callback=cab_func)

while True:
    time.sleep(2)
    print('ts1={}\tts2={}'.format(ts1, ts2))