#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import logging

from agilent4uhv.cmd_template import template_bot, template_channel, template_device, template_sync, template_top
from agilent4uhv.devices import sectors

from common.utils import deploy_files

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info('Use the script at common/generate.py instead !')


def generate(args):
    logger.info('Generating Agilent 4UHV.')
    defaults = {
        'CD': '${TOP}', 'TOP': args.top, 'ASYN': args.asyn, 'ARCH': args.arch, 'EPICS_BASE': args.epics_base,
        'STREAM_PROTOCOL_PATH': '$(TOP)/protocol', 'LOG_ADDR': args.epics_log_addr, 'LOG_PORT': args.epics_log_port}

    EPICS_CA_PORT_INCRESE = args.epics_ca_port_increase
    EPICS_CA_SERVER_PORT = args.base_epics_ca_port
    CMD_KEY = args.cmd_prefix

    dir_name = os.path.dirname(os.path.abspath(__file__))
    for sector in sectors:
        res = ''

        devices = sector['devices']
        IP_ASYN_PORT = sector['IP_ASYN_PORT']
        IP_ADDR = sector['IP_ADDR']
        devices_num = 0

        res += template_top.safe_substitute(defaults, IP_ADDR=IP_ADDR, IP_ASYN_PORT=IP_ASYN_PORT,
                                            EPICS_CA_SERVER_PORT=EPICS_CA_SERVER_PORT)

        for i in range(4):
            if devices[i] is None:
                devices[i] = {'PREFIX': 'None:{}'.format(i)}
                continue
            devices_num += 1

        res += template_sync.safe_substitute(
            PREFIX_D1=devices[0]['PREFIX'],
            PREFIX_D2=devices[1]['PREFIX'],
            PREFIX_D3=devices[2]['PREFIX'],
            PREFIX_D4=devices[3]['PREFIX'],
            D_NUM=devices_num)
        d_n = 0
        for device in devices:
            d_n += 1
            if device['PREFIX'].startswith('None'):
                continue

            PREFIX = device['PREFIX']
            SERIAL_ADDRESS = device['ADDRESS']

            channels = device['channels']
            p_high = device['high']
            p_hihi = device['hihi']

            for i in range(4):
                if channels[i] is None:
                    channels[i] = 'None:{}'.format(i)

            res += template_device.safe_substitute(
                IP_ASYN_PORT=IP_ASYN_PORT,
                PREFIX=PREFIX,
                SERIAL_ADDRESS=SERIAL_ADDRESS,
                PREFIX_CH1=channels[0],
                PREFIX_CH2=channels[1],
                PREFIX_CH3=channels[2],
                PREFIX_CH4=channels[3],
                DEVICE_NUM=d_n)

            for i in range(4):
                if channels[i].startswith('None'):
                    continue

                res += template_channel.safe_substitute(IP_ASYN_PORT=IP_ASYN_PORT, PREFIX=channels[i],
                                                        P_HIGH=p_high[i], P_HIHI=p_hihi[i],
                                                        SERIAL_ADDRESS=SERIAL_ADDRESS, CHANNEL_NUMBER=i + 1)
        if EPICS_CA_PORT_INCRESE:
            EPICS_CA_SERVER_PORT += 2
        res += template_bot.safe_substitute(defaults)

        if not os.path.exists(os.path.join(dir_name, 'server/cmd/')):
            os.makedirs(os.path.join(dir_name, 'server/cmd/'))

        cmd_path = os.path.join(dir_name, 'server/cmd/' + CMD_KEY + sector['f_name'] + '.cmd')
        with open(cmd_path, 'w+') as file:
            file.write(res)

        os.chmod(cmd_path, 0o544)

    deploy_files(dir_name, defaults['TOP'])
