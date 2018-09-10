#!/bin/bash
 
if [[ -z "${TOP}" ]]; then
    IOC_FOLDER="/opt/stream-ioc/"  
else
    IOC_FOLDER=${TOP}
fi

PROTOCOL="protocol"
IOC_BOOT="iocBoot"
DB="database"

cd template 
./generate.py
cd ..

cp -R db/. ${TOP}/${DB}/
cp -R protocol/. ${TOP}/${PROTOCOL}/

chmod -R 777 cmd/
cp -R cmd/. ${TOP}/${IOC_BOOT}/
