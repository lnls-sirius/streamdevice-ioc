#!/usr/bin/env python3

import logging
import os

from common.utils import deploy_files
from mks937b.db_template import relay as db_relay
from mks937b.devices import sectors as sectors, CC
from mks937b.proto_template import mks937b_pressures_proto
from mks937b.template import (
    template_device,
    template_bot,
    template_top,
    template_pressure,
    template_cc,
    template_relay,
)

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


def generate(args, defaults):
    logger.info("Generating MKS937b.")
    dir_name = os.path.dirname(os.path.abspath(__file__))

    epics_ca_port_increase = args.epics_ca_port_increase
    epics_ca_server_port = args.base_epics_ca_port
    cmd_key = args.cmd_prefix

    rel_db = ""
    rel_db += """
    ################################################################################
    # Automatically generated content.
    # Changes on this file won't be persisted.
    # If the user wishes to modify it's content, change the template instead.
    ################################################################################
    """
    for relay in range(1, 13):
        rel_db += db_relay.safe_substitute(RELAY=relay)

    with open(os.path.join(dir_name, "server/db/mks937b_relay.db"), "w+") as file:
        file.write(rel_db)

    stream_protocol_path = "$(TOP)/protocol"
    cd = "${TOP}"

    for sector in sectors:
        res = ""
        count = 0

        name = cmd_key + sector["f_name"]
        base_proto_name = name

        devices = sector["devices"]
        ip_asyn_port = sector["IP_ASYN_PORT"]
        scan_rate = sector["SCAN_RATE"]
        ip_addr = sector["IP_ADDR"]

        res += template_top.safe_substitute(
            defaults,
            CD=cd,
            STREAM_PROTOCOL_PATH=stream_protocol_path,
            IP_ADDR=ip_addr,
            IP_ASYN_PORT=ip_asyn_port,
            EPICS_CA_SERVER_PORT=epics_ca_server_port,
        )

        for device in devices:
            if device:
                CONFIG = device["CONFIG"]
                PREFIX = device["PREFIX"]
                ADDRESS = device["ADDRESS"]
                pressures = device["pressures"]
                GAUGES = device["GAUGES"]
                proto_name = base_proto_name + "ADDR" + ADDRESS

                cc_array = []
                if CONFIG[0] == CC:
                    cc_array.append(0)
                if CONFIG[1] == CC:
                    cc_array.append(2)
                if CONFIG[2] == CC:
                    cc_array.append(4)

                res += template_device.safe_substitute(
                    IP_ASYN_PORT=ip_asyn_port,
                    PREFIX=PREFIX,
                    SCAN_RATE=scan_rate,
                    ADDRESS=ADDRESS,
                    G1=GAUGES[0],
                    G2=GAUGES[1],
                    G3=GAUGES[2],
                    G4=GAUGES[3],
                    G5=GAUGES[4],
                    G6=GAUGES[5],
                    P_PROTO=proto_name,
                )
                with open(
                    os.path.join(dir_name, "server/protocol/" + proto_name + ".proto"),
                    "w+",
                ) as file:
                    file.write(
                        mks937b_pressures_proto.safe_substitute(
                            G1=GAUGES[0],
                            G2=GAUGES[1],
                            G3=GAUGES[2],
                            G4=GAUGES[3],
                            G5=GAUGES[4],
                            G6=GAUGES[5],
                        )
                    )

                for channel in range(0, 6):
                    res += template_pressure.safe_substitute(
                        IP_ASYN_PORT=ip_asyn_port,
                        D=PREFIX,
                        PREFIX=GAUGES[channel],
                        ADDRESS=ADDRESS,
                        P_HI=pressures[channel].get("HI"),
                        P_HIHI=pressures[channel].get("HIHI"),
                        CHANNEL=channel + 1,
                    )
                for channel in cc_array:
                    res += template_cc.safe_substitute(
                        IP_ASYN_PORT=ip_asyn_port,
                        PREFIX=GAUGES[channel],
                        ADDRESS=ADDRESS,
                        CHANNEL=channel + 1,
                    )

                res += template_relay.safe_substitute(
                    IP_ASYN_PORT=ip_asyn_port, PREFIX=PREFIX, ADDRESS=ADDRESS
                )

                res += "\n"
            count += 1

        if epics_ca_port_increase:
            epics_ca_server_port += 2

        res += template_bot.safe_substitute(defaults, name=name)

        if not os.path.exists(os.path.join(dir_name, "server/cmd/")):
            os.makedirs(os.path.join(dir_name, "server/cmd/"))
        cmd_path = os.path.join(dir_name, "server/cmd/" + name + ".cmd")
        with open(cmd_path, "w+") as file:
            file.write(res)
        os.chmod(cmd_path, 0o544)

        # Generate req file
        gauges = []
        for device in devices:
            for gauge in device["GAUGES"]:
                gauges.append(gauge)

        res_path = os.path.join(dir_name, "server/autosave/" + name + ".req")
        if not os.path.exists(os.path.join(dir_name, "server/autosave/")):
            os.makedirs(os.path.join(dir_name, "server/autosave/"))

        with open(res_path, "w+") as file:
            for gauge in gauges:
                file.write("{}:Pressure-Mon.HIHI\n".format(gauge))
                file.write("{}:Pressure-Mon.HIGH\n".format(gauge))

        os.chmod(res_path, 0o544)

    deploy_files(dir_name, defaults["TOP"])
