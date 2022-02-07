#!/usr/bin/env python3

import logging
import typing
import os

from spixconv.template import (
    top as template_top,
    bot as template_bot,
    docker_compose_tmplt,
    docker_compose_prefix,
)
from spixconv.devices import boards

logger = logging.getLogger()

if __name__ == "__main__":
    logger.info("Use the script at common/generate.py instead !")


class FileManager:
    def __init__(self) -> None:
        self._dir_name = os.path.dirname(os.path.abspath(__file__))
        dirs = ["ioc", "docker", "ioc/cmd", "ioc/db", "ioc/proto"]
        for dir in dirs:
            if not os.path.exists(os.path.join(self._dir_name, dir)):
                os.makedirs(os.path.join(self._dir_name, dir))

        self._docker_compose: typing.IO = open(
            "{}/docker/docker-compose.yml".format(self._dir_name), "w+"
        )

    def write_compose(self, data: str):
        self._docker_compose.write(data)

    def write_cmd(self, data: str, filename: str):
        cmd_path = os.path.join(self._dir_name, "ioc/cmd/{}".format(filename))
        with open(cmd_path, "w+") as file:
            file.write(data)
        os.chmod(cmd_path, 0o774)

    def close(self):
        self._docker_compose.close()


def generate(args, defaults):
    logger.info("Generating SPIxCONV.")
    fm = FileManager()
    fm.write_compose(docker_compose_prefix)

    for board in boards:
        cmd_data = ""
        fm.write_compose(
            docker_compose_tmplt.safe_substitute(
                ADDRESS=board.address,
                DATABASE=board.database,
                DELAY=board.step_delay,
                DESCRIPTION=board.description,
                FILENAME=board.file_name,
                IP_ADDR=board.ip,
                PREFIX=board.device,
                SCAN_RATE=board.scan_rate,
                SERVICE=board.service_name,
                TRIGGER=board.step_trigger,
                VOLTAGE_FACTOR=board.voltage_factor,
            )
        )

        cmd_data += template_top.safe_substitute(
            defaults,
            IP_ADDR=board.ip,
            DATABASE=board.database,
            SCAN_RATE=board.scan_rate,
            PREFIX=board.device,
            VOLTAGE_FACTOR=board.voltage_factor,
            DESCRIPTION=board.description,
            ADDRESS=board.address,
            DELAY=board.step_delay,
            TRIGGER=board.step_trigger,
        )
        cmd_data += template_bot.safe_substitute(defaults, PREFIX=board.device)
        fm.write_cmd(data=cmd_data, filename=board.file_name)

    fm.close()
