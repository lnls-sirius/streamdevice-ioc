#!/usr/bin/python3
import time
import sys

from epics import PV 

pvName = sys.argv[1]

ts = 0
tDelta = 0
tsG = 0
tsM = 0

def callback(pvname=None, value=None, char_value=None, **kwds):
    global ts, tsG, tsM, tDelta
    tsN = kwds['timestamp']
    tDelta = tsN - ts
    if tDelta < 0:
        tDelta = 0
    if tDelta < 1000.:
        if tDelta > tsG:
            tsG = tDelta
        if tsM == 0 :
            tsM = tDelta
        else:
            tsM = (tsM + tDelta) / 2.

        print('Name = {}\tDelta = {}\tLarger = {}\tAverage = {}'.format(pvname,tDelta, tsG, tsM))
    ts = tsN    

pv = PV(pvName,form='time')
pv.add_callback(callback=callback)

while True:
    time.sleep(2)
