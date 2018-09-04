#!/bin/bash
# Stream Device

apt-get -y install libpcre3-dev
cd ${EPICS_MODULES}
mkdir StreamDevice-2.7.11
cd StreamDevice-2.7.11
echo '' | makeBaseApp.pl -t support && echo ''
wget https://github.com/paulscherrerinstitute/StreamDevice/archive/stream_2_7_11.tar.gz
tar -xvzf stream_2_7_11.tar.gz
rm stream_2_7_11.tar.gz
sed -i -e '28iASYN='${ASYN} configure/RELEASE
sed -i -e '29iCALC='${CALC} configure/RELEASE
echo 'PCRE_INCLUDE=/usr/include' > configure/RELEASE.Common.linux-x86_64
echo 'PCRE_LIB=/usr/lib/x86_64-linux-gnu' >> configure/RELEASE.Common.linux-x86_64
sed -i -e '20istreamApp_DBD += system.dbd' StreamDevice-stream_2_7_11/streamApp/Makefile
rm StreamDevice-stream_2_7_11/GNUmakefile
sed -i -e '11iDIRS += StreamDevice-stream_2_7_11' Makefile
make
