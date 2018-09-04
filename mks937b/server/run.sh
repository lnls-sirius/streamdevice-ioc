#!/bin/bash
cd ${HOME_DIR}
git pull
cd server/scripts

if ./build.sh; then
     procServ --chdir ${TOP}/iocBoot 20200 ./${CMD}
     cd scripts
     ./ioc_man.py
else
     echo Something failed to execute!  \(0\`_0\)
fi
