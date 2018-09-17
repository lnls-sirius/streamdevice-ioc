#!/bin/bash

<<<<<<< HEAD
echo Current Enviroments:
echo HOME_DIR $HOME_DIR
echo TOP $TOP
echo BASE_PROCSERV_PORT $BASE_PROCSERV_PORT

# Update repository
=======
>>>>>>> 6fc57ff501609f7be0d5db1848f271694a80ce09
cd ${HOME_DIR}
sleep 1
echo 'Git pull'
git pull
sleep 1

# Clear stram-ioc folder
cd ${TOP}/iocBoot
for filename in *.cmd; do
    if [[ ${filename} =~ ${CMD_KEY}(.*).cmd ]]; then
        rm ${filename}
        echo Removed old content: ${filename}
    fi
done

cd ${HOME_DIR}/server
procServPort=${BASE_PROCSERV_PORT}

# Clear the /cmd folder
rm -r ${HOME_DIR}/server/cmd/*

# Generate .cmd files
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
