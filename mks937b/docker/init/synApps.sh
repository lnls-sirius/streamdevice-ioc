#!/bin/bash
# synApps Calc Module
cd ${EPICS_BASE}/../modules
mkdir synApps
cd synApps
wget https://github.com/epics-modules/calc/archive/R3-7-1.tar.gz
tar -xvzf R3-7-1.tar.gz
rm R3-7-1.tar.gz
sed -i -e '5s/^/#/' -e '7,8s/^/#/' -e '13s/^/#/' -e '20cEPICS_BASE='${EPICS_BASE} calc-R3-7-1/configure/RELEASE
cd calc-R3-7-1
make -j ${MAKE_JOBS}
