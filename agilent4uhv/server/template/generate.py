#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""
import time
import sys 
import argparse

from os import environ

from string import Template
from cmd_template import *

from devices import *

parser = argparse.ArgumentParser(description='Generate Agilent 4UHV IOC files.')
parser.add_argument('--base-epics-ca-port', help='Initial EPICS CA server port. It will increase by 2 for every ioc.',
    type=int, default=5370)
parser.add_argument('--cmd-prefix', 
    default='UHV', help='Prefix for the .cmd files.')
parser.add_argument('--epics-base', 
    default='/opt/epics-R3.15.5/base', help='Epics base path.')
parser.add_argument('--asyn', 
    default='/opt/epics-R3.15.5/modules/asyn4-33', help='Asyn driver path.')
parser.add_argument('--top', 
    default='/opt/stream-ioc', help='Stream-ioc path.')
parser.add_argument('--arch', help='System architecture.', choices=['linux-x86_64', 'linux-arm'],
    default='linux-x86_64')
args = parser.parse_args()

EPICS_BASE = args.epics_base
ASYN = args.asyn
TOP =  args.top
ARCH = args.arch
EPICS_CA_SERVER_PORT = args.base_epics_ca_port 
CMD_KEY = args.cmd_prefix

if __name__ == "__main__":
    CD = "${TOP}"
    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    
    for sector in sectors:
        res = ''
        count = 0

        f_name        = '../cmd/' + CMD_KEY + sector['f_name']
        devices       = sector['devices']
        IP_ASYN_PORT  = sector['IP_ASYN_PORT']
        IP_ADDR       = sector['IP_ADDR']
        devices_num   = 0

        res += template_top.safe_substitute(
                CD=CD,
                EPICS_BASE=EPICS_BASE,
                ASYN=ASYN,
                TOP=TOP,
                ARCH=ARCH,
                STREAM_PROTOCOL_PATH=STREAM_PROTOCOL_PATH,
                IP_ADDR=IP_ADDR,
                IP_ASYN_PORT=IP_ASYN_PORT,
                EPICS_CA_SERVER_PORT=EPICS_CA_SERVER_PORT                
        )
        for i in range(4):
            if devices[i] == None:
                devices[i] = {'PREFIX' : 'None:{}'.format(i)}
                continue
            devices_num += 1

        res += template_sync.safe_substitute(\
                PREFIX_D1=devices[0]['PREFIX'],\
                PREFIX_D2=devices[1]['PREFIX'],\
                PREFIX_D3=devices[2]['PREFIX'],\
                PREFIX_D4=devices[3]['PREFIX'],\
                D_NUM=devices_num)
        d_n = 0
        for device in devices:
            d_n += 1
            if device['PREFIX'].startswith('None'):
                continue

            PREFIX = device['PREFIX']
            SERIAL_ADDRESS = device['ADDRESS'] 

            channels = device['channels']
            
            for i in range(4):
                if channels[i] == None:
                    channels[i] = 'None:{}'.format(i)
            
            res += template_device.safe_substitute(\
                IP_ASYN_PORT=IP_ASYN_PORT,\
                PREFIX=PREFIX,\
                SERIAL_ADDRESS=SERIAL_ADDRESS,\
                PREFIX_CH1=channels[0],\
                PREFIX_CH2=channels[1],\
                PREFIX_CH3=channels[2],\
                PREFIX_CH4=channels[3],\
                DEVICE_NUM=d_n)

            for i in range(4):
                if channels[i].startswith('None'):
                    continue 

                res += template_channel.safe_substitute(
                    IP_ASYN_PORT=IP_ASYN_PORT,
                    PREFIX=channels[i],
                    SERIAL_ADDRESS=SERIAL_ADDRESS,
                    CHANNEL_NUMBER = i + 1 
                )

        EPICS_CA_SERVER_PORT += 2
        res += template_bot

        file = open(f_name + '.cmd', 'w+')
        file.write(res)
        file.close()
        print('\n\n') 
        
