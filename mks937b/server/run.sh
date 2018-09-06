#!/bin/bash
export BASE_PROCSERV_PORT=20200
export TOP=/opt/stream-ioc
export HOME_DIR=/home/carneirofc/dev/sirius-temporary-dev-repo/mks937b

cd ${HOME_DIR}
sleep 2
echo 'Git pull'
git pull
cd ${HOME_DIR}/server
procServPort=${BASE_PROCSERV_PORT}
rm ${TOP}/iocBoot/*.cmd

if ./build.sh; then
    cd ${TOP}/iocBoot
    for filename in *.cmd; do
        procServPort=$((procServPort + 1))
        echo $filename ' prcSevPort' ${procServPort} 
        procServ --chdir ${TOP}/iocBoot ${procServPort} ./${filename}
    done 
    cd ${HOME_DIR}/server/scripts
    ./ioc_man.py
else
    echo The build script failed! \(0\`_0\)
fi
