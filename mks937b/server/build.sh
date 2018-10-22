#!/bin/bash

if [[ -z "${TOP}" ]]; then
    IOC_FOLDER="/opt/stream-ioc/"  
else
    IOC_FOLDER=${TOP}
fi

export BASE_EPICS_CA_SERVER_PORT=5070

PROTOCOL="protocol"
IOC_BOOT="iocBoot"
DB="database"

pushd template 
./generate.py
popd

cp -R db/. ${IOC_FOLDER}/${DB}/
cp -R protocol/. ${IOC_FOLDER}/${PROTOCOL}/

chmod -R 777 cmd/
cp -R cmd/. ${IOC_FOLDER}/${IOC_BOOT}/
