STREAM_IOC_PATH="/opt/stream-ioc/"
# STREAM_IOC_PATH="/home/controle/Desktop/Novo/"


PROTOCOL="protocol/"
IOC_BOOT="iocBoot/"
DB="db/"

cd template 
./generate.py
cd ..

cp -R db/. ${STREAM_IOC_PATH}${DB}
cp -R protocol/. ${STREAM_IOC_PATH}${PROTOCOL}

chmod -R 777 cmd/
cp -R cmd/. ${STREAM_IOC_PATH}${IOC_BOOT}
