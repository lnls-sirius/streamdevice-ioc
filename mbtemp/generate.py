#!/usr/bin/env python3
# # -*- coding: utf-8 -*-

import logging
import os

from mbtemp.devices import boards
from mbtemp.template import mbt_template, mbt_template_bot, mbt_template_top
from common.utils import deploy_files

logger = logging.getLogger()
if __name__ == "__main__":
    logger.info('Use the script at common/generate.py instead !')


def generate(args):
    logger.info('Generating MBTemp.')
    dir_name = os.path.dirname(os.path.abspath(__file__))

    defaults = {
        'CD': '${TOP}', 'TOP': args.top, 'ASYN': args.asyn, 'ARCH': args.arch, 'EPICS_BASE': args.epics_base,
        'STREAM_PROTOCOL_PATH': '$(TOP)/protocol', 'LOG_ADDR': args.epics_log_addr, 'LOG_PORT': args.epics_log_port}

    epics_ca_port_increase = args.epics_ca_port_increase
    epics_ca_server_port = args.base_epics_ca_port
    cmd_key = args.cmd_prefix

    stream_protocol_path = "$(TOP)/protocol"
    cd = "${TOP}"

    # MBTemp specifics
    for board in boards:
        res = ''
        count = 0

        res += mbt_template_top.safe_substitute(defaults, CD=cd, STREAM_PROTOCOL_PATH=stream_protocol_path,
                                                IP_ADDR=board.ip, EPICS_CA_SERVER_PORT=epics_ca_server_port,
                                                IP_ASYN_PORT=board.ip_asyn_port)

        for device in board.devices:
            res += mbt_template.safe_substitute(
                IP_ASYN_PORT=board.ip_asyn_port,
                MBTEMP_ADDRESS=device.address,
                PREFIX=device.prefix,
                SCAN_RATE=board.scan_rate,
                CH1=device.channels[0],
                CH2=device.channels[1],
                CH3=device.channels[2],
                CH4=device.channels[3],
                CH5=device.channels[4],
                CH6=device.channels[5],
                CH7=device.channels[6],
                CH8=device.channels[7])

            count += 1

        if epics_ca_port_increase:
            epics_ca_server_port += 2
        res += mbt_template_bot.safe_substitute(defaults)

        if not os.path.exists(os.path.join(dir_name, 'server/cmd/')):
            os.makedirs(os.path.join(dir_name, 'server/cmd/'))

        cmd_path = os.path.join(dir_name, 'server/cmd/' + cmd_key + board.file_name)
        with open(cmd_path, 'w+') as file:
            file.write(res)

        os.chmod(cmd_path, 0o544)

    deploy_files(dir_name, defaults['TOP'])
