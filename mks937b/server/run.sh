#!/bin/bash
cd ${HOME_DIR}/server/
if ./build.sh; then
    procServ --chdir ${IOC_FOLDER}/iocBoot 20200 ./${CMD}
    cd /scripts
    ./ioc_man.py
else
    echo Something failed to execute!  \(0\`_0\)
fi
