#!/bin/bash
# asynDriver
cd ${EPICS_BASE}
cd ..
mkdir modules
cd modules
wget https://www.aps.anl.gov/epics/download/modules/asyn4-33.tar.gz
tar -xvzf asyn4-33.tar.gz
rm asyn4-33.tar.gz
sed -i -e '3,4s/^/#/' -e '8s/^/#/' -e '11s/^/#/' -e '14cEPICS_BASE='${EPICS_BASE} asyn4-33/configure/RELEASE
cat  asyn4-33/configure/RELEASE
cd asyn4-33
make -j ${MAKE_JOBS}
 
cd ..
tree -d 
