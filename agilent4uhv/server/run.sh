#!/bin/bash

echo Current Enviroments:
echo HOME_DIR $HOME_DIR
echo TOP $TOP
echo BASE_PROCSERV_PORT $BASE_PROCSERV_PORT

# Update repository
echo 'Git pull'
git pull
sleep 1

# Clear stram-ioc folder
pushd ${TOP}/iocBoot
    for filename in *.cmd; do
        if [[ ${filename} =~ ${CMD_KEY}(.*).cmd ]]; then
            rm ${filename}
            echo Removed old content: ${filename}
        fi
    done
popd

procServPort=${BASE_PROCSERV_PORT}

# Clear the /cmd folder
rm -r cmd/*

# Generate .cmd files
if ./build.sh; then
    pushd ${TOP}/iocBoot
        for filename in *; do
            if [[ ${filename} =~ ${CMD_KEY}(.*).cmd ]]; then
                echo " "
                procServPort=$((procServPort + 1))
                procServ --chdir ${TOP}/iocBoot ${procServPort} ./${filename}  
                echo Init procServ at port ${procServPort} ${filename}
                echo " "
            fi
        done 
    popd
    
    # cd scripts
    # ./ioc_man.py
else
    echo The build script failed!
fi
