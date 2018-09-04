#!/bin/bash
echo 'stream-ioc'
cd /opt/
git clone --recursive https://github.com/lnls-sirius/stream-ioc.git
rm stream-ioc/configure/RELEASE
touch stream-ioc/configure/RELEASE
echo "EPICS_BASE=${EPICS_BASE}" >> stream-ioc/configure/RELEASE
echo "ASYN=${ASYN}" >> stream-ioc/configure/RELEASE
echo "CALC=${CALC}" >> stream-ioc/configure/RELEASE
cd stream-ioc
rm StreamDevice/GNUmakefile
make -j ${MAKE_JOBS}
