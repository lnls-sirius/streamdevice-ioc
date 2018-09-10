#!/bin/bash

# The envs bellow are to be set inside the container.
# So if you are using docker remove them from this file !

cd ${HOME_DIR}
sleep 1
echo 'Git pull'
git pull
sleep 1

cd ${TOP}/iocBoot
for filename in *.cmd; do
    if [[ ${filename} =~ ${CMD_KEY}(.*).cmd ]]; then
        rm ${filename}
        echo Removed old content: ${filename}
    fi
done

cd ${HOME_DIR}/server
procServPort=${BASE_PROCSERV_PORT}

if ./build.sh; then
    cd ${TOP}/iocBoot
    for filename in *; do
        if [[ ${filename} =~ ${CMD_KEY}(.*).cmd ]]; then
            procServPort=$((procServPort + 1))
            procServ --chdir ${TOP}/iocBoot ${procServPort} ./${filename}  
            echo Init procServ at port ${procServPort} ${filename}
        fi
    done 
    cd ${HOME_DIR}/server/scripts
    ./ioc_man.py
else
    echo The build script failed! \(0\`_0\)
fi
