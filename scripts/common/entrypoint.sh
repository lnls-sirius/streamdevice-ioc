#!/bin/sh
set -exu

procServ \
    --logfile - \
    --foreground \
    --chdir "${TOP}/iocBoot/iocStreamDeviceIOC" \
    --name "${IOC_NAME}" \
    "unix:${TOP}/sockets/ioc.sock" \
    "./${IOC_CMD}"
