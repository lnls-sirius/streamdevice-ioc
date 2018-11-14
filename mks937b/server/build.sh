#!/bin/bash
if [[ -z "${TOP}" ]]; then
    IOC_FOLDER="/opt/stream-ioc"  
else
    IOC_FOLDER=${TOP}
fi

PROTOCOL="protocol"
IOC_BOOT="iocBoot"
DB="database"

pushd template
    ./generate.py \
        --base-epics-ca-port ${BASE_EPICS_CA_SERVER_PORT}\
        --cmd-prefix ${CMD_KEY}\
        --top ${IOC_FOLDER} 
popd

chmod -R +x cmd/

cp -R db/. ${IOC_FOLDER}/${DB}/
cp -R protocol/. ${IOC_FOLDER}/${PROTOCOL}/
cp -R cmd/. ${IOC_FOLDER}/${IOC_BOOT}/
