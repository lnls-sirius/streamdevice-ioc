#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
    This template is used to generate the default .cmd iocBoot file.
    The user should pass as parameter the destination file the will be generated.
"""
import logging
import os

from common.utils import deploy_files
from countingPRU.devices import boards
from countingPRU.template import template, template_bot, template_top

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info('Use the script at common/generate.py instead !')


def generate(args):
    logger.info('Generating Counting PRU.')

    defaults = {
        'CD': '${TOP}', 'TOP': args.top, 'ASYN': args.asyn, 'ARCH': args.arch, 'EPICS_BASE': args.epics_base,
        'STREAM_PROTOCOL_PATH': '$(TOP)/protocol', 'LOG_ADDR': args.epics_log_addr, 'LOG_PORT': args.epics_log_port}

    epics_ca_port_increase = args.epics_ca_port_increase
    epics_ca_server_port = args.base_epics_ca_port
    cmd_key = args.cmd_prefix

    stream_protocol_path = "$(TOP)/protocol"
    cd = "${TOP}"

    dir_name = os.path.dirname(os.path.abspath(__file__))
    # CountingPRU specifics
    for board in boards:
        res = ''
        res += template_top.safe_substitute(defaults,
            CD=cd,
            STREAM_PROTOCOL_PATH=stream_protocol_path,
            EPICS_CA_SERVER_PORT=epics_ca_server_port,
            IP=board.ip,
            IP_ASYN_PORT=board.ip_asyn_port)

        counting_device = board.device

        res += template.safe_substitute(
            IP_ASYN_PORT=board.ip_asyn_port,
            COUNTING_DEVICE=counting_device,
            SCAN_RATE=board.scan_rate,
            CH1=board.channels[0],
            CH2=board.channels[1],
            CH3=board.channels[2],
            CH4=board.channels[3],
            CH5=board.channels[4],
            CH6=board.channels[5],
            CH7=board.channels[6],
            CH8=board.channels[7],
            CH1_DESC=board.descs[0],
            CH2_DESC=board.descs[1],
            CH3_DESC=board.descs[2],
            CH4_DESC=board.descs[3],
            CH5_DESC=board.descs[4],
            CH6_DESC=board.descs[5],
            CH7_DESC=board.descs[6],
            CH8_DESC=board.descs[7],
            DETECTOR1_NAME=board.detectornames[0],
            DETECTOR2_NAME=board.detectornames[1],
            DETECTOR3_NAME=board.detectornames[2],
            DETECTOR4_NAME=board.detectornames[3],
            DETECTOR5_NAME=board.detectornames[4],
            DETECTOR6_NAME=board.detectornames[5],
            DETECTOR7_NAME=board.detectornames[6],
            DETECTOR8_NAME=board.detectornames[7])

        if epics_ca_port_increase:
            epics_ca_server_port += 2
        res += template_bot.safe_substitute(defaults)

        if not os.path.exists(os.path.join(dir_name, 'server/cmd')):
            os.makedirs(os.path.join(dir_name, 'server/cmd'))

        cmd_path = os.path.join(dir_name, 'server/cmd/' + cmd_key + board.file_name)
        with open(cmd_path, 'w+') as file:
            file.write(res)
        os.chmod(cmd_path, 0o544)

    deploy_files(dir_name, defaults['TOP'])
