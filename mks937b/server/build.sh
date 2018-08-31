IOC_FOLDER="/opt/stream-ioc/"  
PROTOCOL="protocol/"
IOC_BOOT="iocBoot/"
DB="database/"

cd template 
./generate.py
cd ..

cp -R db/. ${IOC_FOLDER}${DB}
cp -R protocol/. ${IOC_FOLDER}${PROTOCOL}

chmod -R 777 cmd/
cp -R cmd/. ${IOC_FOLDER}${IOC_BOOT}
