#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
import os

from common.utils import deploy_files
from spixconv.cmd_template import top as template_top, bot as template_bot
from spixconv.devices import boards
from common.procCtrl import generate_st_cmd

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info('Use the script at common/generate.py instead !')


def generate(args, defaults):
    logger.info('Generating SPIxCONV.')
    dir_name = os.path.dirname(os.path.abspath(__file__))

    epics_ca_port_increase = args.epics_ca_port_increase
    epics_ca_server_port = args.base_epics_ca_port
    cmd_key = args.cmd_prefix

    cd = "${TOP}"
    stream_protocol_path = "$(TOP)/protocol"

    for board in boards:
        res = ''

        res += template_top.safe_substitute(defaults,
                                            CD=cd, STREAM_PROTOCOL_PATH=stream_protocol_path,
                                            EPICS_CA_SERVER_PORT=epics_ca_server_port,
                                            IP_ADDR=board.ip, DATABASE=board.database, SCAN_RATE=board.scan_rate,
                                            PREFIX=board.device, VOLTAGE_FACTOR=board.voltage_factor,
                                            DESCRIPTION=board.description, ADDRESS=board.address,
                                            DELAY=board.step_delay, TRIGGER=board.step_trigger)
        res += template_bot.safe_substitute(defaults, PREFIX=board.device)

        if epics_ca_port_increase:
            epics_ca_server_port += 2

        if not os.path.exists(os.path.join(dir_name, 'server/cmd/')):
            os.makedirs(os.path.join(dir_name, 'server/cmd/'))
        cmd_path = os.path.join(dir_name, 'server/cmd/' + cmd_key + board.file_name)
        with open(cmd_path, 'w+') as file:
            file.write(res)
        os.chmod(cmd_path, 0o544)
    deploy_files(dir_name, defaults['TOP'])

    # Generate procServControl
    # [{pv:..., ip:...}, ...]
    iocs = []
    for board in boards:
        iocs.append({
            'ip': "/opt/streamdevice-ioc/sockets/{}{}".format(cmd_key, board.ip).replace('.','_').replace(':', '_') + '.sock',
            'pv': "ProcCtrl:" + board.device
        })
    generate_st_cmd(iocs)

