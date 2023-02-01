#!/bin/sh
set -ex

# Parameters:
# 1 - device directory name
[ -z "$1" ] && echo "missing param 1 (device dir)" && exit 1
HW=$1

# Environment Variables:
# TOP - location where the contents will be copied to
[ -z "$TOP" ] && echo "missing 'TOP' environment variable" && exit 1

# Attempt to copy contents into 'TOP/<dir>'
function safe_deploy  {
    # Parameters:
    # 1 - source directory
    # 2 - destination directory ( relative to TOP), defaults to the contents of source
    src=$1
    [ -z "$2" ] && dest=$1 || dest=$2
    [ -d "$src" ] && [ -d "$dest" ] && [ ! -z $(ls $HW/ioc/$src) ] && \
        cp -v -p ./$HW/ioc/$src/* ${TOP}/$dest
}

safe_deploy autosave autosave
safe_deploy db       db
safe_deploy protocol protocol
safe_deploy cmd      iocBoot/iocStreamDeviceIOC
