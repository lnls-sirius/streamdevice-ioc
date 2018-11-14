#!/bin/bash
 
if [[ -z "${TOP}" ]]; then
    IOC_FOLDER="/opt/stream-ioc/"  
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

cp -R db/. ${TOP}/${DB}/
cp -R protocol/. ${TOP}/${PROTOCOL}/

chmod -R 777 cmd/
cp -R cmd/. ${TOP}/${IOC_BOOT}/
