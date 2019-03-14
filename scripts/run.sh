#!/bin/bash
source common/functions

echo Folder ${1}\; Prefix ${2}\; BASE PORT ${3};

build ${1} ${2} ${3};

# Check if it will run using a tcp<->unix socket bridge
set -x
if [[ -z "${SOCKET_BRIDGE}" ]]; then
  run_ioc ${2};
else
  run_ioc_unix_bridge ${2};
fi
set +x

tail -f /dev/null
