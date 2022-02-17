#!/bin/sh
set -ex

[ -z "$1" ] && echo "missing param 1 (device dir)" && exit 1
HW=$1

[ -z "$TOP" ] && echo "missing 'TOP' environment variable" && exit 1

function safe_deploy  {
    src=$1

    [ -z "$2" ] && dest=$1 || dest=$2

    [ -d "$src" ] && [ -d "$dest" ] && [ ! -z $(ls $HW/ioc/$src) ] && \
        cp -v -p ./$HW/ioc/$src/* ${TOP}/$dest
}

safe_deploy autosave autosave
safe_deploy db       db
safe_deploy protocol protocol
safe_deploy cmd      iocBoot/iocStreamDeviceIOC
