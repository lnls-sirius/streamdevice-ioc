#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user sould pass as parameter the destination file the will be generated.
"""
import sys 
from os import environ

from string import Template
from cmd_template import *
from devices import *
# from db_template import *

# rel_db = ''
# for relay in range(1, 13):
#     rel_db += db_relay.safe_substitute(RELAY=relay)
# file = open('../db/mks937b_relay.db', 'w+')
# file.write(rel_db)
# file.close()


if __name__ == "__main__":
    EPICS_BASE = environ.get('EPICS_BASE', '/opt/epics-R3.15.5/base')
    ASYN = environ.get('ASYN', '/opt/epics-R3.15.5/modules/asyn4-33')
    TOP = environ.get('IOC_FOLDER', '/opt/stream-ioc')
    ARCH = environ.get('EPICS_HOST_ARCH', 'linux-x86_64')
    CMD_KEY = environ.get('CMD_KEY', 'Agilent-4UHV-')
    
    STREAM_PROTOCOL_PATH = "$(TOP)/protocol"
    ca_server_port = BASE_EPICS_CA_SERVER_PORT
    CD = "${TOP}"
    
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
                EPICS_CA_SERVER_PORT=ca_server_port                
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

        ca_server_port += 2
        res += template_bot

        file = open(f_name + '.cmd', 'w+')
        file.write(res)
        file.close()

        